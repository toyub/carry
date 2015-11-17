class StoreWorkstationCategorySerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :workstations
end
