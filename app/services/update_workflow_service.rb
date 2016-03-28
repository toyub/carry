class UpdateWorkflowService
  include Serviceable

  def initialize(options)
    @workflow = options.fetch(:workflow, [])
  end

  def call
    @workflow.each do |id, attrs|
      attrs[:mechanics] = attrs[:mechanics].values if attrs[:mechanics]
      if attrs[:mechanics].blank?
        return false
      end
      w = StoreServiceWorkflowSnapshot.find(id)
      attrs.delete(:mechanics).each do |mechanic|
        task = StoreStaffTask.find_by(workflow_id: w.id, mechanic_id: mechanic[:id])
        task ||= StoreStaffTask.create(
          workflow_id: w.id,
          mechanic_id: mechanic[:id],
          store_order_item_id: w.store_order_item_id,
          store_staff_id: w.store_staff_id,
          store_id: w.store_id,
          store_chain_id: w.store_chain_id
        )
      end
      w.update!(attrs)
    end
    true
  end
end
