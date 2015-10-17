class StoreMaterialCategorySerializer < ActiveModel::Serializer
  attributes :id, :store_id, :parent_id, :name

  has_many :sub_categories
end
