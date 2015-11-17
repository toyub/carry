# == Schema Information
#
# Table name: store_physical_inventory_items
#
#  id                          :integer          not null, primary key
#  store_id                    :integer          not null
#  store_chain_id              :integer          not null
#  store_staff_id              :integer          not null
#  store_material_id           :integer          not null
#  store_depot_id              :integer          not null
#  store_inventory_id          :integer          not null
#  store_physical_inventory_id :integer          not null
#  inventory                   :integer          not null
#  physical                    :integer          not null
#  diff                        :integer          not null
#  inventory_cost_price        :decimal(10, 2)
#  cost_price                  :decimal(10, 2)
#  remark                      :string(255)
#  status                      :integer          default(0)
#  created_at                  :datetime
#  updated_at                  :datetime
#

class StorePhysicalInventoryItemSerializer < ActiveModel::Serializer
  attributes :id, :inventory, :physical, :diff, :store_material, :remark, :store_inventory_id, :store_depot_id

  def store_material
    StoreMaterialSerializer.new(self.object.store_material).as_json(root:nil)
  end
end
