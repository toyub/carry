class StoreDepot  < ActiveRecord::Base
  include BaseModel
  has_many :store_material_inventories
end
