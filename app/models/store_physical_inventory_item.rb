class StorePhysicalInventoryItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material
  scope :status_is, ->(stat){
    if stat.present?
      where(status: stat)
    end
  }

  scope :diff_is, ->(diff){
    if diff.present?
      if diff.to_i == 1
        where('diff > 0')
      elsif diff.to_i == -1
        where('diff < 0')
      end
    end
  }
end

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
