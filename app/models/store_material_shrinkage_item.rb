class StoreMaterialShrinkageItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material_inventory
  belongs_to :store_material
end

# == Schema Information
#
# Table name: store_material_shrinkage_items
#
#  id                          :integer          not null, primary key
#  store_id                    :integer          not null
#  store_chain_id              :integer          not null
#  store_staff_id              :integer          not null
#  store_material_shrinkage_id :integer          not null
#  store_material_id           :integer          not null
#  store_depot_id              :integer          not null
#  store_material_inventory_id :integer          not null
#  quantity                    :integer
#  prior_quantity              :integer
#  cost_price                  :decimal(10, 2)
#  inventory_cost_price        :decimal(10, 2)
#  amount                      :decimal(10, 2)
#  remark                      :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#
