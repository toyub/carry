class StoreMaterialPickingItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_staff
  belongs_to :store_material
  belongs_to :store_material_picking
  belongs_to :store_material_inventory
  belongs_to :store_depot
  belongs_to :dest_depot, class_name: 'StoreDepot'

  def latest_depot_cost_price(inventory)
    (inventory.cost_price.to_f * inventory.quantity.to_i + self.quantity*self.inventory_cost_price)/(inventory.quantity+self.quantity)
  end
end
