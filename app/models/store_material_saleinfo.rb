class StoreMaterialSaleinfo  <  ActiveRecord::Base
  belongs_to :store_material
  belongs_to :saleman_commission_template, class_name: 'StoreCommissionTemplate', foreign_key: 'saleman_commission_template_id'
  has_many :services, class_name:'StoreMaterialSaleinfoService'

  accepts_nested_attributes_for :services
  
end
