class VehicleModel < ActiveRecord::Base
  has_many :store_vehicles
  scope :models, ->(series_id) { where(vehicle_series_id: series_id) }
end
