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
    self.store.store_orders.available.has_service.task_queuing.each do |order|
      service = order.store_service_snapshots.not_deleted.pending.order_by_itemd.first
      if service.present?
        workflow = service.workflow_snapshots.not_deleted.pending.order_by_flow.first
        if workflow.present?
          if workflow.executable?(self)
            workflow.execute!(self)
          end
        end
      end
    end
  end

  def finish!
    if self.workflow_id.blank? || self.current_workflow.blank? || self.current_workflow.deleted
      self.free
      return true
    end
    workflow = self.current_workflow
    workflow.complete!
    if workflow.next_workflow.present?
      workflow.next_workflow.find_a_workstaion_and_execute_otherwise_waiting_in(self)
    else
      workflow.store_service.complete!
    end
    if self.current_workflow.blank?
      assign_workflow!
    end
  end

  def free?
    current_workflow.blank?
  end

  def free
    self.update!(workflow_id: nil)
    self.idle!
  end

  def perform!(store_order, workflow)
    workflow.complete!
    if workflow.next_workflow.present?
      workflow.next_workflow.find_a_workstaion_and_execute_otherwise_waiting_in(self)
    else
      workflow.store_service.complete!
    end
  end

  def start!(workflow)
    workflow.execute(self) if workflow.executable?(self)
  end
end
