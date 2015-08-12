class StoreMaterialSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit, :barcode, :speci

  def unit
    object.store_material_unit.name
  end
end
