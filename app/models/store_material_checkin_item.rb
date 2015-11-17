class StoreMaterialCheckinItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material_checkin
  belongs_to :store_material
  belongs_to :store_material_inventory

  def cost_price
    self.price
  end
end

# == Schema Information
#
# Table name: store_material_checkin_items
#
#  id                          :integer          not null, primary key
#  store_id                    :integer          not null
#  store_chain_id              :integer          not null
#  store_staff_id              :integer          not null
#  store_depot_id              :integer          not null
#  store_material_id           :integer          not null
#  store_material_inventory_id :integer          not null
#  store_material_checkin_id   :integer          not null
#  quantity                    :integer          not null
#  prior_quantity              :integer
#  price                       :decimal(10, 2)
#  amount                      :decimal(10, 2)
#  prior_cost_price            :decimal(10, 2)
#  latest_cost_price           :decimal(10, 2)
#  remark                      :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#
