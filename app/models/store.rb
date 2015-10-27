class Store <  ActiveRecord::Base
  belongs_to :store_chain
  has_many :store_materials
  has_many :store_material_categories
  has_many :store_material_units
  has_many :store_material_brands
  has_many :store_material_orders
  has_many :store_material_manufacturers
  has_many :store_depots
  has_many :store_suppliers
  has_many :store_material_inventories
  has_many :store_services
  has_many :service_categories, class_name: 'StoreServiceCategory'
  has_many :store_workstation_categories
  has_many :store_commission_templates
  has_many :store_staff
  has_many :store_material_returnings
  has_many :store_material_returning_items
  has_many :store_settlement_accounts

  validates :name, presence: true

  has_many :workstations, class_name: 'StoreWorkstation'
  has_many :commission_templates, class_name: 'StoreCommissionTemplate'

  # 一级商品类别
  has_many :root_material_categories, -> { where parent_id: 0 },
    class_name: 'StoreMaterialCategory'

  validates :name, presence: true

  ENGINEER_LEVEL = {
    '初级' => 1,
    '中级' => 2,
    '高级' => 3
  }
end

# == Schema Information
#
# Table name: stores
#
#  id              :integer          not null, primary key
#  store_chain_id  :integer          not null
#  admin_id        :integer
#  name            :string(60)       not null
#  created_at      :datetime
#  updated_at      :datetime
#  business_status :boolean          default(TRUE)
#  payment_status  :boolean          default(TRUE)
#
