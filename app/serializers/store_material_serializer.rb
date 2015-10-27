# == Schema Information
#
# Table name: store_materials
#
#  id                              :integer          not null, primary key
#  store_id                        :integer          not null
#  store_chain_id                  :integer          not null
#  store_staff_id                  :integer          not null
#  store_material_root_category_id :integer          not null
#  store_material_category_id      :integer          not null
#  store_material_unit_id          :integer          not null
#  store_material_manufacturer_id  :integer          not null
#  store_material_brand_id         :integer          not null
#  name                            :string(100)      not null
#  barcode                         :string(45)
#  mnemonic                        :string(45)
#  speci                           :string(45)
#  cost_price                      :decimal(10, 2)
#  min_price                       :decimal(10, 2)
#  inventory_alarmify              :boolean          default(FALSE)
#  min_inventory                   :integer
#  max_inventory                   :integer
#  expiry_alarmify                 :boolean          default(FALSE)
#  shelf_life                      :integer
#  permitted_to_internal           :boolean          default(TRUE), not null
#  permitted_to_saleable           :boolean          default(FALSE), not null
#  remark                          :text
#  created_at                      :datetime
#  updated_at                      :datetime
#

class StoreMaterialSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit, :barcode, :speci, :root_category, :category, :cost_price, :mode, :root_category_id, :category_id, :remark

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
end
