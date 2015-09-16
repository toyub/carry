class StoreMaterialPickingItem < ActiveRecord::Base
  belongs_to :sotre
  belongs_to :store_chain
  belongs_to :store_staff
  belongs_to :store_material
  belongs_to :store_material_picking
  belongs_to :store_material_inventory
  belongs_to :store_depot
end
