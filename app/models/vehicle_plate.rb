class VehiclePlate < ActiveRecord::Base
  belongs_to :store_vehicle
  belongs_to :plate, class_name: 'VehicleRegistrationPlate', foreign_key: :vehicle_registration_plate_id

  enum status: %i[ normal disable ]
end
