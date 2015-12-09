class StoreMaterialSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit, :barcode, :speci, :root_category, :category, :cost_price, :mode, :root_category_id, :category_id, :remark, :price

  def unit
    object.store_material_unit.name
  end

  def root_category
    object.store_material_root_category.try(:name)
  end

  def category
    object.store_material_category.try(:name)
  end

  def category_id
    object.store_material_category_id
  end

  def root_category_id
    object.store_material_root_category_id
  end

  def mode
    "领用"
  end

  def price
    object.cost_price
  end
end
