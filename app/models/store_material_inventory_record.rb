class StoreMaterialInventoryRecord < ActiveRecord::Base
  belongs_to :store_material
  belongs_to :store_material_order
  belongs_to :store_material_order_item
  belongs_to :store_material_inventory
end
