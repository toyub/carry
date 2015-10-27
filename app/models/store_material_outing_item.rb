class StoreMaterialOutingItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_staff
  belongs_to :requester, class_name: 'StoreStaff'
  belongs_to :store_material_inventory
  belongs_to :store_material

  def outing_type
    OutingType.find(self.outing_type_id)
  end
end

# == Schema Information
#
# Table name: store_material_outing_items
#
#  id                          :integer          not null, primary key
#  outing_type_id              :integer
#  store_id                    :integer          not null
#  store_chain_id              :integer          not null
#  store_staff_id              :integer          not null
#  store_material_outing_id    :integer          not null
#  requester_id                :integer
#  store_material_id           :integer          not null
#  store_material_inventory_id :integer          not null
#  store_depot_id              :integer          not null
#  quantity                    :integer
#  amount                      :decimal(10, 2)
#  cost_price                  :decimal(10, 2)
#  inventory_cost_price        :decimal(10, 2)
#  remark                      :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#
