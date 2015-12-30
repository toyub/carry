class VehicleSeries < ActiveRecord::Base
  has_many :store_vehicles
  scope :series, ->(brand_id) { where(vehicle_brand_id: brand_id) }
end
