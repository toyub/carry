class StoreWorkstation < ActiveRecord::Base
  include BaseModel

  belongs_to :store_workstation_category
end
