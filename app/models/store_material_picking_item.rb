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

  def outing_type
    OutingType.find_by_name('转移出库')
  end
end

# == Schema Information
#
# Table name: store_material_picking_items
#
#  id                          :integer          not null, primary key
#  store_id                    :integer          not null
#  store_chain_id              :integer          not null
#  store_staff_id              :integer          not null
#  store_depot_id              :integer          not null
#  dest_depot_id               :integer          not null
#  store_material_id           :integer          not null
#  store_material_inventory_id :integer          not null
#  store_material_picking_id   :integer          not null
#  quantity                    :integer          not null
#  cost_price                  :decimal(10, 2)   not null
#  amount                      :decimal(10, 2)
#  inventory_cost_price        :decimal(10, 2)
#  remark                      :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#
