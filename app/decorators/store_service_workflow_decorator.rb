class StoreServiceWorkflowDecorator
  def initialize(workflow, options = {})
    @workflow = workflow
  end

  def engineer_levels
    StoreServiceWorkflow::ENGINEER_LEVEL.keys
  end

  ## TODO 为什么不取名workstations?
  def store_workstations
    StoreWorkstation.all
  end

  def commissions
    @workflow.store.store_commission_templates
  end

  def method_missing(meth, *args)
    if @workflow.respond_to?(meth)
      @workflow.send(meth, *args)
    else
      super
    end
  end
end
