class StoreMaterialSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit, :barcode, :speci, :root_category, :category, :cost_price

  def unit
    object.store_material_unit.name
  end

  def root_category
    object.store_material_root_category.name
  end

  def category
    object.store_material_category.name
  end
end
