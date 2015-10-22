class StoreMaterialOrder < ActiveRecord::Base
  belongs_to :store_material
  has_many :store_material_inventories
  has_many :store_material_order_items
  belongs_to :store_supplier

  accepts_nested_attributes_for :store_material_order_items
  scope :pending, ->{where('store_material_orders.process = 0')}
  scope :suspense, ->{where('0 < store_material_orders.process and store_material_orders.process < 100')}
  scope :finished, ->{where('store_material_orders.process = 100')}
end
