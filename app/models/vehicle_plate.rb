class VehiclePlate < ActiveRecord::Base
  belongs_to :store_vehicle
  belongs_to :plate, class_name: 'StoreVehicleRegistrationPlate', foreign_key: :store_vehicle_registration_plate_id
end
