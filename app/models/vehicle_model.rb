class VehicleModel < ActiveRecord::Base
  has_many :store_vehicles
  scope :models, ->(series_id) { where(vehicle_series_id: series_id) }
  belongs_to :vehicle_series

  validates :name, presence: true, uniqueness: {scope: 'vehicle_series_id'} 
end
