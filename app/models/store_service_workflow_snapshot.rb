class StoreServiceWorkflowSnapshot < ActiveRecord::Base
  include BaseModel
  attr_reader :overtime_interval, :overtime_reason

  belongs_to :store_order_item
  belongs_to :store_service, class_name: "StoreServiceSnapshot", foreign_key: :store_service_id
  belongs_to :sales_commission, class_name: 'StoreCommissionTemplate', foreign_key: :sales_commission_template_id
  belongs_to :engineer_commission, class_name: 'StoreCommissionTemplate', foreign_key: :engineer_commission_template_id
  belongs_to :store_service_workflow
  belongs_to :store_workstation
  belongs_to :store_order
  belongs_to :store_vehicle

  validates :store_staff_id, presence: true
  validates :store_service_id, presence: true

  scope :of_store, -> (store_id) { where(store_id: store_id) }

  enum status: [:pending, :processing, :finished]

  def workstations
    stations = StoreWorkstation.where(id: self.workstaiton_ids)
    return stations if stations.present?
    StoreWorkstation.all
  end

  def workstaiton_ids
    self.store_workstation_ids.to_s.split(",").map(&:to_i)
  end

  def work_time_in_minutes
    self.standard_time.to_i + self.buffering_time.to_i + self.factor_time.to_i
  end

  def mechanics
    read_attribute(:mechanics) || []
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
    self.processing!
    self.store_order.task_processing!
    self.store_order.processing!
  end

  def count_down
    self.used_time - self.elapsed_time
  end

  def elapsed_time
    ((Time.now - self.started_time)/60).ceil
  end

  def actual_time_in_minutes
    elapsed_time
  end

  def finish!
    self.store_workstation.idle!
    self.finished!
    self.update!(elapsed: actual_time_in_minutes)
    self.store_order.finish!
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
