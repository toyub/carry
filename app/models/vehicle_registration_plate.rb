class VehicleRegistrationPlate < ActiveRecord::Base
  has_many :vehicle_plates
  has_many :store_vehicles, through: :vehicle_plates
  validates :license_number, uniqueness: true
end
