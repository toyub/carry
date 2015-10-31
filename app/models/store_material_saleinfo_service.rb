class StoreMaterialSaleinfoService < ActiveRecord::Base
  include BaseModel
  
  belongs_to :store_material
  belongs_to :store_material_saleinfo
  belongs_to :mechanic_commission_template, class_name: 'StoreCommissionTemplate', foreign_key: 'mechanic_commission_template_id'

  def mechanic_level_type
    ServiceMechanicLevelType.find(self.mechanic_level).name
  end
end
