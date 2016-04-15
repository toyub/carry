class StoreServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :engineer_levels, :workstations, :point, :category, :retail_price,
    :bargain_price, :unit, :code, :introduction, :remark, :price

  has_many :store_service_workflows, root: :store_service_workflows_attributes
  has_many :uploads
  has_many :store_materials
  has_many :reminds
  has_many :trackings
  has_one :setting

  def engineer_levels
    StoreServiceWorkflow::ENGINEER_LEVEL
  end

  def workstations
    object.store.workstations
  end

  def category
    object.service_category.try(:name)
  end

  def price
    object.retail_price
  end

  def unit
    object.unit.try(:name)
  end
end
