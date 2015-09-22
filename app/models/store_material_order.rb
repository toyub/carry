class StoreMaterialOrder < ActiveRecord::Base
  belongs_to :store_material
  belongs_to :store_supplier

  has_many :store_material_inventories
  has_many :items, class_name: 'StoreMaterialOrderItem'
  

  accepts_nested_attributes_for :items
  scope :pending, ->{where('store_material_orders.process = 0')}
  scope :suspense, ->{where('0 < store_material_orders.process and store_material_orders.process < 100')}
  scope :finished, ->{where('store_material_orders.process = 100')}
end
