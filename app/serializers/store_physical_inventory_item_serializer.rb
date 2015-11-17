class StorePhysicalInventoryItemSerializer < ActiveModel::Serializer
  attributes :id, :inventory, :physical, :diff, :store_material, :remark, :store_inventory_id, :store_depot_id

  def store_material
    StoreMaterialSerializer.new(self.object.store_material).as_json(root:nil)
  end
end
