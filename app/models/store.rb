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
  has_many :store_services
  has_many :service_categories, class_name: 'StoreServiceCategory'
  has_many :store_workstation_categories
  has_many :store_commission_templates

  validates :name, presence: true

end
