class StoreMaterialOrder < ActiveRecord::Base
  belongs_to :store_material
  has_many :store_material_inventories
  has_many :store_material_order_items

  accepts_nested_attributes_for :store_material_order_items
end
