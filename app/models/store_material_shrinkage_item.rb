class StoreMaterialShrinkageItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material_inventory
  belongs_to :store_material
  belongs_to :store_material_shrinkage

  def format_created_at
    created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def numero
    store_material_shrinkage.numero
  end
end
