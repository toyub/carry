class StoreMaterialInventorySerializer < ActiveModel::Serializer
  attributes :id, :quantity, :store_depot_id, :store_material

  def store_material
    StoreMaterialSerializer.new(self.object.store_material).as_json(root: nil)
  end
end
