class StoreWorkstation < ActiveRecord::Base
  include BaseModel

  belongs_to :store_workstation_category
  belongs_to :current_workflow, class_name: 'StoreServiceWorkflowSnapshot', foreign_key: :workflow_id

  validates :name, presence: true, uniqueness: true

  scope :of_store, -> (store_id) { where(store_id: store_id) }
  scope :available, -> { where.not(status: self.statuses[:unavailable]) }

  enum status: [:idle, :busy, :unavailable]

  def assign_workflow!
    pending_workflows.each do |w|
      w.execute!(self) and break if w.executable?
    end
  end

  def pending_workflows
    StoreServiceWorkflowSnapshot.of_store(store_id).pending.order("created_at asc").to_a.select do |w|
      w.store_workstation_id == self.id || w.workstations.map(&:id).include?(self.id)
    end
  end

  def finish!
    ActiveRecord::Base.transaction do
      current_workflow.finish!
      self.free
      SpotDispatchJob.perform_later(self.store_id)
    end
  end

  def free?
    current_workflow.blank?
  end

  def dispatch
    if free?
      SpotDispatchJob.perform_later(self.store_id)
    else
      if current_workflow.count_down <= 0
        finish!
      end
    end
  end

  def free
    self.update!(workflow_id: nil)
    self.idle!
  end

  def perform!(store_order)
    ActiveRecord::Base.transaction do
      store_order.workflows.processing.first.try(:finish!)
      store_order.workflows.pending.order("created_at asc").each do |w|
        w.execute(self) and break if w.executable?
      end
    end
  end
end
