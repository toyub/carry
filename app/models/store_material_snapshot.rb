class StoreMaterialSnapshot < ActiveRecord::Base
  belongs_to :store
  belongs_to :store_chain
  belongs_to :store_material_unit
  belongs_to :store_material_brand
  belongs_to :store_material_category
  belongs_to :store_material_root_category, class_name: 'StoreMaterialCategory', foreign_key: 'store_material_root_category_id'
  belongs_to :store_material_manufacturer
  belongs_to :creator, class_name: 'Staff', foreign_key: 'store_staff_id'

  has_many :store_material_commissions
  has_one :smc_salesman
  has_one :smc_mechanic
  has_one :store_material_saleinfo
  has_one :store_material_tracking
  has_one :store_order_item, as: :orderable

  has_many :store_material_inventories
  belongs_to :store_material

end

# == Schema Information
#
# Table name: store_material_snapshots
#
#  id                              :integer          not null, primary key
#  store_id                        :integer          not null
#  store_chain_id                  :integer          not null
#  store_staff_id                  :integer          not null
#  store_material_root_category_id :integer          not null
#  store_material_category_id      :integer          not null
#  store_material_unit_id          :integer          not null
#  store_material_manufacturer_id  :integer          not null
#  store_material_brand_id         :integer          not null
#  name                            :string(45)       not null
#  barcode                         :string(45)
#  mnemonic                        :string(45)
#  speci                           :string(45)
#  cost_price                      :decimal(10, 2)
#  min_price                       :decimal(10, 2)
#  inventory_alarmify              :boolean          default(FALSE)
#  min_inventory                   :integer
#  max_inventory                   :integer
#  expiry_alarmify                 :boolean          default(FALSE)
#  shelf_life                      :integer
#  permitted_to_internal           :boolean          default(TRUE), not null
#  permitted_to_saleable           :boolean          default(FALSE), not null
#  remark                          :text
#  created_at                      :datetime
#  updated_at                      :datetime
#  store_material_id               :integer
#
