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
  has_many :mechanics, through: :tasks
  has_many :store_group_members, through: :tasks
  belongs_to :inspector, class_name: 'StoreStaff', foreign_key: :inspector_id

  validates :store_staff_id, presence: true
  validates :store_service_id, presence: true

  scope :of_store, -> (store_id) { where(store_id: store_id) }
  scope :unfinished, -> { where.not(status: StoreServiceWorkflowSnapshot.statuses[:finished]) }
  scope :not_deleted, ->{where(deleted: false)}
  scope :not_finished, -> { where.not(status: StoreServiceWorkflowSnapshot.statuses[:finished]) }

  scope :previous_siblings_of, ->(flow_id){where('store_service_workflow_id < ?', flow_id)}
  scope :next_siblings_of, ->(flow_id){where('store_service_workflow_id > ?', flow_id)}

  scope :order_by_flow, ->{order('store_service_workflow_id asc')}
  scope :actively, ->{where(status: [ StoreServiceWorkflowSnapshot.statuses[:processing], StoreServiceWorkflowSnapshot.statuses[:dilemma] ])}

  enum status: [:pending, :processing, :finished, :pausing, :dilemma]
  enum waiting_area_id: %i[ waiting_in_queue waiting_in_workstation ]

  def ready_mechanics(workstation_id)
    workstation = StoreWorkstation.find_by(id: workstation_id)
    if workstation.present?
      workstation.store_group.store_group_members.available.attendances
    else
      []
    end
  end

  def workstations
    default_workstation_ids = self.store_workstation_ids.to_s.split(",").map(&:to_i)
    if default_workstation_ids.present?
      stations = StoreWorkstation.where(id: default_workstation_ids).available
      if stations.present?
        return stations
      else
        return store.workstations.available
      end
    else
      return store.workstations.available
    end
  end

  def find_a_workstaion_and_execute
    if self.store_workstation.blank?
      self.workstations.each do |ws|
        if self.executable?(ws)
          self.execute!(ws)
          break
        end
      end
    end
  end

  def raise_a_dilemma(workstation)
    if self.processing?
      return
    end

    if self.store_workstation.blank?
      self.store_workstation = workstation
    end
    self.store_workstation.current_workflow = self
    self.store_workstation.busy!
    self.dilemma!
  end

  def find_a_workstaion_and_execute_otherwise_waiting_in(workstation)
    if self.executable?(workstation)
      self.execute!(workstation)
    else
      self.find_a_workstaion_and_execute
    end
    if self.store_workstation.blank? || !self.processing?
      raise_a_dilemma(workstation)
    end
  end

  def executable?(workstation)
    if self.processing?
      return true
    end
    
    if self.store_vehicle.blank?
      self.errors.add(:store_vehicle, "订单无效:订单所属车辆为空。无法进行施工！")
      return false
    end

    if self.is_pausing?
      self.errors.add(:status, "当前施工项目已经暂停，请先恢复施工状态！")
      return false
    end

    unless self.has_qualified_mechaincs?(workstation)
      return false
    end

    unless self.store_vehicle.workflows.processing.where.not({id: self.id}).blank?
      self.errors.add(:already, '该车辆正在施工其他项目！')
      return false
    end

    unless big_brothers_finished?
      self.errors.add(:brothers, '该车辆已经在施工其他流程！')
      return false
    end

    return true
  end

  def has_qualified_mechaincs?(workstation)
    if self.tasks.present?
      if self.store_group_members.any?(&:absence?)
        self.errors.add(:mechanics, '无法开始施工，因为指定的技师中有未出勤的技师。若要开始请重新分配技师！')
        return false
      end
      if self.store_group_members.all?(&:ready?)
        return true
      else
        if self.store_group_members.all?(&->(member){member.current_processing_workflow.try(:id) == self.id})
          return true
        else
          self.errors.add(:mechanics, '无法开始施工，因为指定的技师中有正在施工其他项目的技师。若要开始请重新分配技师！')
          return false
        end
      end
    else
      if workstation.store_group.blank?
        self.errors.add(:mechanics, '无法开始施工，工位没有绑定小组，无法分配技师！')
        return false
      end
      available_mechanics_count = workstation.store_group
                                             .store_group_members
                                             .available
                                             .ready.level_at_least(mechanics_level.to_i).count
      if available_mechanics_count >= mechanics_quantity
        return true
      else
        self.errors.add(:mechanics, "无法开始施工，因为技师数量不满足；该服务需要 #{mechanics_quantity}个技师，而只分配了#{available_mechanics_count}个！")
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
      self.destroy
      return false
    end
    ActiveRecord::Base.transaction do
      self.execute(workstation)
    end
  end

  def execute(workstation)
    assign_workstation(workstation)
    assign_mechanics
    self.processing!
    self.store_order.task_processing!
    self.store_order.processing!
    send_sms
  end

  def change_workstation_to!(workstation)
    if self.store_workstation.present?
      self.store_workstation.free
    end

    if self.processing?
      execute(workstation)
    else
      assign_workstation(workstation)
    end
  end

  def task_the_mechanic(group_member)
    task_attributes = {
      store_id: self.store_id,
      store_chain_id: self.store_chain_id,
      store_staff_id: self.store_staff_id,
      store_order_item_id: self.store_order_item_id,
      store_group_member_id: group_member.id,
      mechanic_id: group_member.member.id
    }
    task = self.tasks.create!(task_attributes)
    task.store_group_member.busy!
  end

  def assign_mechanics
    if self.tasks.blank?
      self.store_workstation
          .store_group
          .store_group_members
          .available.ready
          .level_at_least(mechanics_level.to_i)
          .order_by_update
          .first(mechanics_quantity).each(&->(group_member){task_the_mechanic(group_member)})
    end
  end

  def assign_workstation(ws)
    self.store.workstations.with_workflow(self.id).where.not({id: ws.id}).each(&:free)
    self.update!(store_workstation_id: ws.id, started_time: Time.now, used_time: work_time_in_minutes)
    ws.update!(workflow_id: self.id)
    ws.busy!
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
      self.update(used_time: will_used_time)
      will_used_time
    end
  end

  def count_down
    self.used_time.to_i - self.elapsed_time
  end

  def elapsed_time
    if is_pausing? || self.started_time.blank?
      return 0
    else
      ((Time.now - self.started_time)/60).floor
    end
  end

  def ended_at
    if self.finished_at.present?
      self.finished_at
    else
      self.estimated_completed_time
    end
  end

  def estimated_completed_time
    if self.started_time.present?
      self.count_down.minutes.from_now(self.started_time)
    else
      self.count_down.minutes.from_now(Time.now)
    end
  end

  def actual_time_in_minutes
    elapsed_time
  end

  def is_pausing?
    self.persisted? && (self.pausing? || self.store_service.pausing? || self.store_order.task_pausing?)
  end

  def pause_in_workstation!
    self.waiting_in_workstation!
    self.pausing!
    self.free_mechanics
  end

  def pause_in_queue!
    self.waiting_in_queue!
    self.pausing!
    self.free_mechanics
    self.free_workstation
  end

  def replay!
    if self.waiting_in_workstation?
      self.processing!
      self.store_workstation.start!(self)
    else
      self.pending!
      workstations.idle.each do |workstation|
        if self.executable?(workstation)
          self.execute!(workstation)
          break
        end
      end
    end
  end

  def complete!
    self.free_workstation
    self.free_mechanics
    self.finish_tasks
    self.record_times
    self.finished!
    send_sms

    if self.next_workflow.present?
      self.next_workflow.find_a_workstaion_and_execute_otherwise_waiting_in(self.store_workstation)
    else
      self.store_service.complete!
    end

    self
  end

  def discontinue!
    self.free_workstation
    self.free_mechanics
    self.finish_tasks
    self.record_times
    self.finished!
    nil
  end

  def remove!
    self.free_workstation
    self.free_mechanics
    self.tasks.destroy_all
  end

  def waste!
    self.tasks.each(&->(task){task.waste!})
    self.update!(deleted: true)
  end

  def free_workstation
    self.store_workstation.try(:free)
  end

  def free_mechanics
    self.store_group_members.map(&:free!)
  end

  def finish_tasks
    self.tasks.each(&:finished!)
  end

  def record_times
    self.update!(elapsed: actual_time_in_minutes, finished_at: Time.now)
  end

  def send_sms
    SmsJob.set(wait_until: remind_delay_interval.minutes.from_now).perform_later(sms_options) if can_send_sms?
  end

  def next_workflow
    next_siblings.first
  end

  private
  def big_brothers_finished?
    big_brothers.all? { |w| w.finished? }
  end

  def big_brothers
    if self.store_service.present?
      self.store_service.workflow_snapshots
                        .not_deleted
                        .pending
                        .order_by_flow
                        .previous_siblings_of(self.store_service_workflow_id)
    else
      []
    end
  end

  def next_siblings
    if self.store_service.present?
      self.store_service.workflow_snapshots
                        .not_deleted
                        .pending
                        .order_by_flow
                        .next_siblings_of(self.store_service_workflow_id)
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
