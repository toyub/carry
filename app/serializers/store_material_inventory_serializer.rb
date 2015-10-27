# == Schema Information
#
# Table name: store_material_inventories
#
#  id                :integer          not null, primary key
#  store_id          :integer          not null
#  store_chain_id    :integer          not null
#  store_staff_id    :integer          not null
#  store_material_id :integer          not null
#  store_depot_id    :integer          not null
#  cost_price        :decimal(10, 2)   default(0.0)
#  quantity          :integer          default(0), not null
#  created_at        :datetime
#  updated_at        :datetime
#

class StoreMaterialInventorySerializer < ActiveModel::Serializer
  attributes :id, :quantity, :store_depot_id, :store_material, :depot_name

  def store_material
    StoreMaterialSerializer.new(self.object.store_material).as_json(root: nil)
  end

  def depot_name
    self.object.store_depot.name
  end
end
