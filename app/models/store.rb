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

  # 一级商品类别
  has_many :root_material_categories, -> { where parent_id: 0 },
    class_name: 'StoreMaterialCategory'

  validates :name, presence: true
  
end
