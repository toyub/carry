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

  enum status: [:pending, :processing, :finished]

  def ready_mechanics(workstation_id)
    workstation = StoreWorkstation.find(workstation_id)
    workstation.store_group.members.select {|m| m.store_group_member.ready?} if workstation
  end

  def workstations
    stations = StoreWorkstation.where(id: self.workstaiton_ids)
    return stations if stations.present?
    StoreWorkstation.all #FIXME: store.workstations
  end

  def free_workstations
    self.workstations.idle
  end

  def screen_workstations
    self.store_order.task_queuing? ? free_workstations : workstations
  end

  def workstaiton_ids
    self.store_workstation_ids.to_s.split(",").map(&:to_i)
  end

  def work_time_in_minutes
    self.standard_time.to_i + self.buffering_time.to_i + self.factor_time.to_i
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

  def executable?
    self.store_vehicle.workflows.processing.blank? && big_brothers_finished?
  end

  def execute!(workstation)
    ActiveRecord::Base.transaction do
      self.execute(workstation)
    end
  end

  def execute(workstation)
    self.update!(store_workstation_id: workstation.id, started_time: Time.now, used_time: work_time_in_minutes)
    workstation.update!(current_workflow: self)
    workstation.busy!
    self.mechanics.map(&:store_group_member).map(&:busy!)
    self.processing!
    self.store_order.task_processing!
    self.store_order.processing!
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
    return 0 unless self.started_time
    ((Time.now - self.started_time)/60).ceil
  end

  def actual_time_in_minutes
    elapsed_time
  end

  def finish!
    self.terminate!
    self.store_order.finish!
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

  private
  def big_brothers_finished?
    big_brothers.all? { |w| w.finished? }
  end

  def big_brothers
    store_service.workflow_snapshots.order("id asc").to_a.select do |w|
      w.id < self.id
    end
  end

end
