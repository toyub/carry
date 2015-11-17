class StoreMaterialReturningItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_staff
  belongs_to :store_material
  belongs_to :store_material_returning
  belongs_to :store_supplier
  belongs_to :store_material_inventory
  belongs_to :store_depot

end
