#store material transfer receipt items
class StoreMaterialTransReceiptItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material_picking
  belongs_to :store_material_picking_item
  belongs_to :sotre_material_inventory
  belongs_to :store_material_receipt
  belongs_to :store_material

  def amount
    self.quantity * self.ordered_cost_price
  end
end

# == Schema Information
#
# Table name: store_material_trans_receipt_items
#
#  id                             :integer          not null, primary key
#  store_id                       :integer          not null
#  store_chain_id                 :integer          not null
#  store_staff_id                 :integer          not null
#  store_depot_id                 :integer          not null
#  store_material_id              :integer          not null
#  store_material_picking_id      :integer          not null
#  store_material_picking_item_id :integer          not null
#  store_material_inventory_id    :integer          not null
#  store_material_receipt_id      :integer          not null
#  quantity                       :integer          not null
#  prior_quantity                 :integer
#  ordered_quantity               :integer
#  prior_cost_price               :decimal(10, 2)
#  ordered_cost_price             :decimal(10, 2)
#  inventory_cost_price           :decimal(10, 2)
#  latest_cost_price              :decimal(10, 2)
#  remark                         :string(255)
#  created_at                     :datetime
#  updated_at                     :datetime
#
