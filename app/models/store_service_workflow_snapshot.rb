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
  scope :not_deleted, ->{where(deleted: false)}

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

  def mechanics
    #TODO:
    tasks.map(&:mechanic).compact
  end

  def has_mechanic?
    mechanics.present? || has_free_mechanic?
  end

  def has_free_mechanic?
    self.store.store_staff.mechanics.map(&:store_group_member).any? {|mem| mem.ready? && mem.eligible_for?(self)}
  end

  def executable?(workstation)
    if self.store_vehicle.blank?
      self.errors.add(:store_vehicle, "订单无效:订单所属车辆为空。无法进行施工！")
      return false
    end

    if self.store_order.task_pausing?
      self.errors.add(:status, "当前施工项目已经暂停，请先恢复施工状态！")
      return false
    end

    unless self.has_qualified_mechaincs?(workstation)
      return false
    end

    unless self.store_vehicle.workflows.processing.where.not({id: self.id}).blank?
      self.errors.add(:already, '该车辆已经在其他工位施工！')
      return false
    end

    unless big_brothers_finished?
      self.errors.add(:processing, '该车辆正在施工其他项目！')
      return false
    end

    return true
  end

  def has_qualified_mechaincs?(workstation)
    if self.tasks.present?
      if self.mechanics.all?(&->(m){m.store_group_member.ready?})
        return true
      else
        self.errors.add(:mechanics, '无法开始施工，因为指定的技师中有正在忙碌的技师。若要开始请重新分配技师！')
        return false
      end
    else
      available_mechanics_count = workstation.store_group
                                             .store_group_members
                                             .available
                                             .ready.level_at_least(mechanics_level.to_i).count
      if available_mechanics_count >= mechanics_quantity
        return true
      else
        self.errors.add(:mechanics, '无法开始施工，因为技师数量不满足；该服务需要 #{mechanics_quantity}个技师，而只分配了#{available_mechanics_count}个！')
        return false
      end
    end
  end

  def mechanics_quantity
    if self.engineer_count_enable
      [self.engineer_count.to_i.abs, 1].max
    else
      1
    end
  end

  def mechanics_level
    if self.engineer_level_enable
      self.engineer_level.to_i
    else
      ServiceMechanicLevelType.find_by_name('初级以上(含初级)').id
    end
  end

  def execute!(workstation)
    if self.store_service.blank?
      self.store_order.waste!
      return 'FUCK OFF'
    end
    ActiveRecord::Base.transaction do
      self.execute(workstation)
    end
  end

  def execute(workstation)
    assign_workstation(workstation)
    if self.tasks.blank?
      self.store_workstation
          .store_group
          .store_group_members
          .available.ready
          .level_at_least(mechanics_level.to_i)
          .limit(mechanics_quantity).each(&->(group_member){assign_mechanic(group_member)})
    end
    self.mechanics.each do |mechanic|
     mechanic.store_group_member.busy!
   end
    self.processing!
    self.store_order.task_processing!
    self.store_order.processing!
    send_sms
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

  def work_time_in_minutes
    if self.used_time.to_i > 0
      return self.used_time.to_i
    else
      needed_time = self.standard_time.to_i + self.buffering_time.to_i + self.factor_time.to_i
      needed_time > 0 ? needed_time : 2
    end
  end

  def real_work_time
    if self.used_time.to_i > 0
      return self.used_time
    else
      will_used_time = work_time_in_minutes
      self.update(:used_time, will_used_time)
      will_used_time
    end
  end

  def count_down
    self.used_time.to_i - self.elapsed_time
  end

  def elapsed_time
    if pausing? || self.started_time.blank?
      return 0
    else
      ((Time.now - self.started_time)/60).ceil
    end
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
    self.update!(elapsed: actual_time_in_minutes, finished_at: Time.now)
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
    if self.store_service.present?
      store_service.workflow_snapshots.order("id asc").where('id < ?', self.id)
    else
      []
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
