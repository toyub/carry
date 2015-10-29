class StoreMaterialSaleinfo  <  ActiveRecord::Base
  belongs_to :store_material
  belongs_to :saleman_commission_template, class_name: 'StoreCommissionTemplate'
end
