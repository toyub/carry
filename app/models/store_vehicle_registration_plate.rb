class StoreVehicleRegistrationPlate < ActiveRecord::Base
  include BaseModel

  belongs_to :creator, class_name: 'StoreStaff', foreign_key: :store_staff_id
  belongs_to :store_customer
  belongs_to :store_vehicle
end
