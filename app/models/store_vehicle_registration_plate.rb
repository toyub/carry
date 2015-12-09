class StoreVehicleRegistrationPlate < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer
  belongs_to :store_vehicle
end
