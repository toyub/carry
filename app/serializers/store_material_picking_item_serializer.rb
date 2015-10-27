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

class StoreMaterialPickingItemSerializer < ActiveModel::Serializer
  attributes :id, :store_material, :quantity, :origin_depot_name, :dest_depot_name

  def origin_depot_name
    self.object.store_depot.name
  end

  def store_material
    StoreMaterialSerializer.new(self.object.store_material).as_json(root:nil)
  end

  def dest_depot_name
    self.object.dest_depot.name
  end
end
