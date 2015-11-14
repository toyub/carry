class StorePackageItemSerializer < ActiveModel::Serializer
  attributes :id, :package_itemable_type, :package_itemable_id, :denomination, :price, :name, :quantity
end
