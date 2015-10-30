class StoreMaterialSaleinfo  <  ActiveRecord::Base

  include BaseModel

  belongs_to :store_material_saleinfo_category
  belongs_to :store_material
  belongs_to :saleman_commission_template, class_name: 'StoreCommissionTemplate', foreign_key: 'saleman_commission_template_id'
  has_many :services, class_name:'StoreMaterialSaleinfoService'

  accepts_nested_attributes_for :services

end
