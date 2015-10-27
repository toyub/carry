class StoreMaterialInventoryRecord < ActiveRecord::Base
  belongs_to :store_material
  belongs_to :store_material_order
  belongs_to :store_material_order_item
  belongs_to :store_material_inventory
end

# == Schema Information
#
# Table name: store_material_inventory_records
#
#  id                           :integer          not null, primary key
#  store_id                     :integer          not null
#  store_chain_id               :integer          not null
#  store_staff_id               :integer          not null
#  store_depot_id               :integer          not null
#  store_material_id            :integer          not null
#  store_material_order_id      :integer          not null
#  store_material_order_item_id :integer          not null
#  store_material_inventory_id  :integer          not null
#  store_material_receipt_id    :integer          not null
#  quantity                     :integer          not null
#  prior_quantity               :integer
#  ordered_quantiry             :integer
#  prior_cost_price             :decimal(10, 2)
#  ordered_cost_price           :decimal(10, 2)
#  latest_cost_price            :decimal(10, 2)
#  created_at                   :datetime
#  updated_at                   :datetime
#
