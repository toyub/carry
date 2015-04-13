class StoreMaterialInventory < ActiveRecord::Base
  belongs_to :store_material
  belongs_to :store_material_order
  belongs_to :store_material_order_item
  has_many :store_material_inventory_records
end
