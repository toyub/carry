class StoreWorkstation < ActiveRecord::Base
  include BaseModel

  belongs_to :store_workstation_category
  belongs_to :current_workflow, class_name: 'StoreServiceWorkflowSnapshot', foreign_key: :workflow_id

  validates :name, presence: true, uniqueness: true

  scope :of_store, -> (store_id) { where(store_id: store_id) }

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
      self.update!(workflow_id: nil)
      self.idle!
      SpotDispatchJob.perform_later(self.store_id)
    end
  end
end
