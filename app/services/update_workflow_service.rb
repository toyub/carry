class UpdateWorkflowService
  include Serviceable

  def initialize(options)
    @workflow = options.fetch(:workflow, [])
  end

  def call
    @workflow.each do |id, attrs|
      attrs[:mechanics] = attrs[:mechanics].values if attrs[:mechanics]
      w = StoreServiceWorkflowSnapshot.find(id)
      w.update!(attrs)
    end
    true
  end
end
