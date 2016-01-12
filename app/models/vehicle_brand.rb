class VehicleBrand < ActiveRecord::Base
  has_many :store_vehicles
  has_many :vehicle_manufacturers
  has_many :vehicle_series

  validates :name, presence: true, uniqueness: true
end
