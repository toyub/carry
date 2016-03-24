class VehicleManufacturer < ActiveRecord::Base
  has_many :vehicle_series

  validates :name, presence: true, uniqueness: true

  scope :by_brand, ->(brand_id) { where(vehicle_brand_id: brand_id)}
end
