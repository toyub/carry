class VehicleSeries < ActiveRecord::Base
  has_many :store_vehicles
  has_many :vehicle_models
  belongs_to :vehicle_brand
  belongs_to :vehicle_manufacturer

  validates :name, presence: true, uniqueness: {scope: :vehicle_manufacturer_id}

  scope :by_manufacturer, ->(manufacturer_id) { where(vehicle_manufacturer_id: manufacturer_id)}
end
