class StoreWorkstation < ActiveRecord::Base
  include BaseModel

  belongs_to :store_workstation_category
  belongs_to :current_workflow, class_name: 'StoreServiceWorkflowSnapshot', foreign_key: :workflow_id
  belongs_to :store_group

  validates :name, presence: true, uniqueness: {scope: :store_id}

  scope :of_store, -> (store_id) { where(store_id: store_id) }
  scope :with_workflow, -> (workflow_id) { where(workflow_id: workflow_id) }
  scope :available, -> { where.not(status: self.statuses[:unavailable]) }

  enum status: [:idle, :busy, :unavailable]

  def working?
    if self.workflow_id.blank? || self.current_workflow.blank? || self.current_workflow.deleted
      self.free
      return false
    else
      return self.busy?
    end
  end

  def assign_workflow!
    pending_workflows.each do |w|
      if w.executable?(self)
        w.execute!(self)
        break
      end
    end
  end

  def pending_workflows
    StoreServiceWorkflowSnapshot.of_store(store_id).not_deleted.pending.order("id asc").select do |w|
      w.store_workstation_id == self.id || w.workstations.map(&:id).include?(self.id)
    end
  end

  def finish!
    ActiveRecord::Base.transaction do
      if current_workflow.present?
        current_workflow.finish!
      end
      self.free
      SpotDispatchJob.perform_now(self.store_id)
    end
  end

  def free?
    current_workflow.blank?
  end

  def dispatch
    if free?
      SpotDispatchJob.perform_now(self.store_id)
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

  def perform!(store_order, workflow)
    ActiveRecord::Base.transaction do
      workflow.try(:finish!)
      w = store_order.workflows.pending.order("created_at asc").first
      return if w.blank?
      w.executable?(self) ? w.execute(self) : w.assign_workstation(self)
    end
  end

  def start!(workflow)
    workflow.execute(self) if workflow.executable?(self)
  end
end
