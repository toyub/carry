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
  has_many :store_physical_inventories
  has_many :workstations, class_name: 'StoreWorkstation'
  has_many :commission_templates, class_name: 'StoreCommissionTemplate'
  has_many :store_packages
  has_many :store_deposits, class_name: 'StoreDepositCard'
  has_many :store_departments
  has_many :store_positions
  has_many :store_customers
  has_many :store_customer_categories
  belongs_to :admin, class_name: 'StoreStaff'
  has_many :store_infos
  
  has_many :uploads, class_name: 'StoreFile', as: :fileable, dependent: :destroy

  has_many :store_payments

  has_many :store_switches

  # 一级商品类别
  has_many :root_material_categories, -> { where parent_id: 0 },
    class_name: 'StoreMaterialCategory'

  validates :name, presence: true

  ENGINEER_LEVEL = {
    '初级' => 1,
    '中级' => 2,
    '高级' => 3
  }

  def engineer_levels
    ENGINEER_LEVEL.invert
  end
end
