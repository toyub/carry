class StoreMaterialPickingItemSerializer < ActiveModel::Serializer
  attributes :id, :store_material, :quantity, :origin_depot_name, :dest_depot_name

  def origin_depot_name
    self.object.store_depot.name
  end

  def store_material
    StoreMaterialSerializer.new(self.object.store_material).as_json(root:nil)
  end

  def dest_depot_name
    self.object.dest_depot.name
  end
end
