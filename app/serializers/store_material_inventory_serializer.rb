class StoreMaterialInventorySerializer < ActiveModel::Serializer
  attributes :id, :quantity, :store_depot_id, :store_material, :depot_name

  def store_material
    StoreMaterialSerializer.new(self.object.store_material).as_json(root: nil)
  end

  def depot_name
    self.object.store_depot.name
  end
end
