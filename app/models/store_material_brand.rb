class StoreMaterialBrand < ActiveRecord::Base
  include BaseModel
  has_many :store_materials
end
