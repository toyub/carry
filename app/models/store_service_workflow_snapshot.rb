class StoreServiceWorkflowSnapshot < ActiveRecord::Base
  include BaseModel
  attr_reader :overtime_interval, :overtime_reason

  belongs_to :store_order_item
  belongs_to :store_service, class_name: "StoreServiceSnapshot", foreign_key: :store_service_id
  belongs_to :mechanic_commission, class_name: 'StoreCommissionTemplate', foreign_key: :mechanic_commission_template_id
  belongs_to :store_service_workflow
  belongs_to :store_workstation
  belongs_to :store_order
  belongs_to :store_vehicle
  has_many :tasks, class_name: 'StoreStaffTask', foreign_key: :workflow_id

  validates :store_staff_id, presence: true
  validates :store_service_id, presence: true

  scope :of_store, -> (store_id) { where(store_id: store_id) }
  scope :unfinished, -> { where.not(status: StoreServiceWorkflowSnapshot.statuses[:finished]) }

  enum status: [:pending, :processing, :finished]

  def ready_mechanics(workstation_id)
    workstation = StoreWorkstation.find(workstation_id)
    workstation.store_group.members if workstation
  end

  def workstations
    stations = StoreWorkstation.where(id: self.workstaiton_ids)
    return stations if stations.present?
    store.workstations
  end

  def workstaiton_ids
    self.store_workstation_ids.to_s.split(",").map(&:to_i)
  end

  def work_time_in_minutes
    self.standard_time.to_i + self.buffering_time.to_i + self.factor_time.to_i
  end

  def real_work_time
    return used_time.to_i if used_time.to_i > 0
    work_time_in_minutes
  end

  def mechanics
    tasks.map(&:mechanic).compact
  end

  def has_mechanic?
    mechanics.present? || has_free_mechanic?
  end

  def has_free_mechanic?
    self.store.store_staff.mechanics.map(&:store_group_member).any? {|mem| mem.ready? && mem.eligible_for?(self)}
  end

  def executable?(workstation)
    return false if self.store_vehicle.blank?
    !self.store_order.task_pausing? && self.has_qualified_mechaincs?(workstation) && self.store_vehicle.workflows.processing.where.not({id: self.id}).blank? && big_brothers_finished?
  end

  def has_qualified_mechaincs?(workstation)
    if self.tasks.present?
      self.mechanics.all? { |m| m.store_group_member.ready? }
    else
      workstation.store_group.store_group_members.ready.select do |engineer|
        engineer.member.level_type_id.to_i >= mechanics_level.to_i
      end.size >= mechanics_quantity
    end
  end

  def mechanics_quantity
    self.engineer_count_enable ? [self.engineer_count, 1].max : 1
  end

  def mechanics_level
    (self.engineer_level if self.engineer_level_enable) || ServiceMechanicLevelType.find_by_name('初级以上(含初级)').id
  end

  def execute!(workstation)
    ActiveRecord::Base.transaction do
      self.execute(workstation)
    end
  end

  def exchange!(previous_workstation, workstation)
    previous_workstation.free
    (!self.pausing? && self.processing?) ? execute(workstation) : assign_workstation(workstation)
  end

  def assign_mechanic(engineer)
    self.tasks.create!(
      mechanic_id: engineer.member.id,
      store_order_item_id: self.store_order_item_id,
      store_staff_id: self.store_staff_id,
      store_id: self.store_id,
      store_chain_id: self.store_chain_id
    )
  end

  def execute(workstation)
    assign_workstation(workstation)
    self.store_workstation.store_group.store_group_members.ready.select do |engineer|
      engineer.member.level_type_id >= mechanics_level
    end.first(mechanics_quantity).each { |engineer| assign_mechanic(engineer) } unless self.tasks.present?
    self.mechanics.map(&:store_group_member).map(&:busy!)
    self.processing!
    self.store_order.task_processing!
    self.store_order.processing!
    send_sms
  end

  def assign_workstation(ws)
    self.store.workstations.with_workflow(self.id).where.not({id: ws.id}).each(&:free)
    self.update!(store_workstation_id: ws.id, started_time: Time.now, used_time: work_time_in_minutes)
    ws.update!(workflow_id: self.id)
    ws.busy!
  end

  def play!
    self.store_workstation.start!(self)
  end

  def assign_mechanics
    return if mechanics.present?
    store_staff = self.store.store_staff.mechanics.map(&:store_group_member).select {|mem| mem.ready? && mem.eligible_for?(self)}.first.member
    StoreStaffTask.create!(
      workflow_id: self.id,
      mechanic_id: store_staff.id,
      store_order_item_id: self.store_order_item_id,
      store_staff_id: self.store_staff_id,
      store_id: self.store_id,
      store_chain_id: self.store_chain_id
    )
  end

  def set_mechanic_busy
    self.mechanics.map(&:store_group_member).map(&:busy!)
  end

  def count_down
    self.used_time.to_i - self.elapsed_time
  end

  def elapsed_time
    return 0 if pausing? || self.started_time.blank?
    ((Time.now - self.started_time)/60).ceil
  end

  def pausing?
    self.store_order.task_pausing?
  end

  def ended_at
    self.count_down.minutes.from_now.strftime("%Y/%m/%d %H:%M:%S")
  end

  def actual_time_in_minutes
    elapsed_time
  end

  def finish!
    self.terminate!
    self.store_order.finish!
    send_sms
  end

  def terminate!
    self.free_workstation
    self.free_mechanics
    self.finished!
    self.update!(elapsed: actual_time_in_minutes)
  end

  def free_workstation
    self.store_workstation.try(:free)
  end

  def free_mechanics
    self.mechanics.map(&:store_group_member).map(&:free!)
  end

  def remove!
    self.free_workstation
    self.free_mechanics
    self.tasks.delete_all
  end

  def waste!
    self.tasks.each(&->(task){task.waste!})
    self.update!(deleted: true)
  end

  def send_sms
    SmsJob.set(wait_until: remind_delay_interval.minutes.from_now).perform_later(sms_options) if can_send_sms?
  end

  def pause_in_workstation!
    self.free_mechanics if self.processing?
  end

  def pause_in_queuing_area!
    self.free_workstation
    self.free_mechanics if self.processing?
  end

  def waiting_in_workstation?
    self.store_workstation.present? && self.store_workstation.workflow_id == self.id
  end

  private
  def big_brothers_finished?
    big_brothers.all? { |w| w.finished? }
  end

  def big_brothers
    store_service.workflow_snapshots.order("id asc").to_a.compact.select do |w|
      w.id < self.id
    end
  end

  def can_send_sms?
    (started? || service_finished?) && sms_enabled?
  end

  def sms_options
    {
      store_id: self.store_id,
      receiver_type: 'StoreCustomer',
      receiver_id: self.store_order.store_customer_id,
      content: message,
      first_category: SmsNotifySwitchType.name,
      second_category: SmsNotifySwitchType.find_by_name('施工流程提醒').try(:id)
    }
  end

  def message
    store_service.message(remind_type) || "尊敬的客户，您的爱车开始施工流程——#{name}"
  end

  def remind_delay_interval
    store_service.remind_delay_interval(remind_type)
  end

  def sms_enabled?
    store_service.sms_enabled?(remind_type)
  end

  def remind_type
    if started?
      :started
    elsif service_finished?
      :finished
    end
  end

  def started?
    self.processing?
  end

  def service_finished?
    self.persisted? && self.finished? && store_service.workflow_snapshots.reject {|w| w.id == self.id}.all? {|w| w.finished?}
  end

end
