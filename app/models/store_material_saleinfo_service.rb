class StoreMaterialSaleinfoService < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material_saleinfo
  belongs_to :mechanic_commission_template, class_name: 'StoreCommissionTemplate', foreign_key: 'mechanic_commission_template_id'

  MECHANIC_LEVELS = {
    0 => "初级以上(含初级)",
    1 => "中级以上(含中级)",
    2 => "高级以上(含高级)",
    3 => "专家"
  }
end
