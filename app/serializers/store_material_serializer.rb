class StoreMaterialSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit

  def unit
    object.store_material_unit.name
  end
end
