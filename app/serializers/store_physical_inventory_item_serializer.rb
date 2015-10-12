class StorePhysicalInventoryItemSerializer < ActiveModel::Serializer
  attributes :id, :inventory, :physical, :diff, :store_material, :remark
  
  def store_material
    StoreMaterialSerializer.new(self.object.store_material).as_json(root:nil)
  end
end
