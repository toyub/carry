class VehicleSeries < ActiveRecord::Base
  has_many :store_vehicles
  scope :series, ->(brand_id) { where(vehicle_brand_id: brand_id) }
  has_many :vehicle_models
  belongs_to :vehicle_brand
  belongs_to :vehicle_manufacturer

  validates :name, presence: true, uniqueness: true
end
