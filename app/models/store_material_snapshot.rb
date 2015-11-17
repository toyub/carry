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
