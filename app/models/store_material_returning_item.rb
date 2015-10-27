class StoreMaterialReturningItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_staff
  belongs_to :store_material
  belongs_to :store_material_returning
  belongs_to :store_supplier
  belongs_to :store_material_inventory
  belongs_to :store_depot

end

# == Schema Information
#
# Table name: store_material_returning_items
#
#  id                          :integer          not null, primary key
#  store_id                    :integer          not null
#  store_chain_id              :integer          not null
#  store_staff_id              :integer          not null
#  store_supplier_id           :integer          not null
#  store_material_id           :integer          not null
#  store_material_inventory_id :integer          not null
#  store_depot_id              :integer          not null
#  store_material_returning_id :integer          not null
#  quantity                    :integer          not null
#  price                       :decimal(10, 2)   not null
#  prior_quantity              :integer          not null
#  remark                      :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#
