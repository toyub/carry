class StoreServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :engineer_levels, :workstations, :commissions

  has_many :store_service_workflows, root: :store_service_workflows_attributes

  def engineer_levels
    StoreServiceWorkflow::ENGINEER_LEVEL
  end

  def workstations
    StoreWorkstation.all
  end

  def commissions
    object.store.store_commission_templates
  end
end
