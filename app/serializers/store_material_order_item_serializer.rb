class StoreMaterialOrderItemSerializer < ActiveModel::Serializer
  attributes :id, :store_material_order_id, :quantity, :price, :amount, :store_material

  def store_material
    StoreMaterialSerializer.new(self.object.store_material).as_json(root: nil)
  end
end
