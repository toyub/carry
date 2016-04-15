class VehicleModel < ActiveRecord::Base
  has_many :store_vehicles
  belongs_to :vehicle_series

  validates :name, presence: true, uniqueness: {scope: :vehicle_series_id}

  scope :by_series, ->(series_id) { where(vehicle_series_id: series_id)}
end
