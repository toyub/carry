class StoreVehicleRegistrationPlate < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer
  belongs_to :store_vehicle

  # 车牌
  has_many :vehicle_plates
  has_many :store_vehicles, through: :vehicle_plates

  validates :license_number, presence: true

end
