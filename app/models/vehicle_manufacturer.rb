class VehicleManufacturer < ActiveRecord::Base
  has_many :vehicle_series
  
  validates :name, presence: true, uniqueness: true
end
