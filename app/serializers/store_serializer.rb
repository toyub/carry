class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :service_categories
  has_many :root_material_categories
  has_many :store_materials
end
