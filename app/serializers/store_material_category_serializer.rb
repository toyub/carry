class StoreMaterialCategorySerializer < ActiveModel::Serializer
  attributes :id, :store_id, :parent_id, :name
end
