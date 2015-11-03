class StoreMaterialShrinkageItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material_inventory
  belongs_to :store_material
end
