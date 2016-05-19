class StoreMaterialReturningItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_staff
  belongs_to :store_material
  belongs_to :store_material_returning
  belongs_to :store_supplier
  belongs_to :store_material_inventory
  belongs_to :store_depot



  def format_created_at
    created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def numero
    store_material_returning.numero
  end

end
