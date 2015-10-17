class StoreMaterialSaleinfoService < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material_saleinfo

  MECHANIC_LEVELS = {
    0 => "初级以上(含初级)",
    1 => "中级以上(含中级)",
    2 => "高级"
  }
end