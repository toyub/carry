class StoreMaterialSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit, :barcode, :speci, :root_category, :category, :cost_price, :remark

  def unit
    object.store_material_unit.name
  end

  def root_category
    object.store_material_root_category.try(:name)
  end

  def category
    object.store_material_category.try(:name)
  end
end
