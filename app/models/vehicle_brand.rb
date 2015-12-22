class VehicleBrand < ActiveRecord::Base
  has_many :store_vehicles
end
