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
  has_many :store_material_saleinfos
  has_many :store_vehicle_registration_plates
  has_many :store_vehicles

  has_many :uploads, class_name: 'StoreFile', as: :fileable, dependent: :destroy
  has_many :store_customer_entities, class_name: 'StoreCustomerEntity'
  has_many :store_orders

  has_many :store_payments

  has_many :store_switches
  has_many :store_customer_entities, class_name: 'StoreCustomerEntity'
  has_many :store_orders
  has_many :store_customer_categories

  has_one :sms_balance, as: :party
  has_many :sms_records

  has_many :tags, class_name: 'Tag::StoreCustomer'
  has_many :workflows, class_name: 'StoreServiceWorkflowSnapshot'

  # 一级商品类别
  has_many :root_material_categories, -> { where parent_id: 0 },
    class_name: 'StoreMaterialCategory'

  has_many :store_groups
  has_many :store_group_members

  validates :name, presence: true

  ENGINEER_LEVEL = {
    '初级' => 1,
    '中级' => 2,
    '高级' => 3
  }

  def engineer_levels
    StoreStaffLevel::ID_TYPES
  end

  def increase_balance!(amount)
    self.class.unscoped.where(id: self.id).update_all("balance=COALESCE(balance, 0) + #{balance.to_f.abs}")
  end

  def decrease_balance!(amount)
    self.class.unscoped.where(id: self.id).update_all("balance=COALESCE(balance, 0) - #{balance.to_f.abs}")
  end

  def info_by(name)
    self.store_infos.where(info_category_id: InfoCategory.find_by(name: name).id).first.try(:value)
  end

  def province
    Geo.state(1, self.info_by('省份')).try(:name)
  end

  def city
    Geo.city(1, self.info_by('省份'), self.info_by('城市')).try(:name)
  end

  def address
    self.info_by('详细地址')
  end

  def business_hours
    "#{self.info_by('上班时间')}~#{self.info_by('下班时间')}"
  end

  def last_year_sales
    last_year = Date.today.year - 1
    self.store_orders.where('extract(year from created_at) = ?', last_year).sum(:amount)
  end

  def current_year_sales
    current_year = Date.today.year
    self.store_orders.where('extract(year from created_at) = ?', current_year).sum(:amount)
  end
end
