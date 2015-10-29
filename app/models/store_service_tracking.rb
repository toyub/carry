class StoreServiceTracking < ActiveRecord::Base
  include BaseModel

  belongs_to :store_service

end
