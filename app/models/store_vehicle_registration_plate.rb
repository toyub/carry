class StoreVehicleRegistrationPlate < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer

  has_many :orders, class_name: 'StoreOrder'

  # 车牌
  has_many :vehicle_plates
  has_many :store_vehicles, through: :vehicle_plates

  validates :license_number, presence: true, uniqueness: true, format: { with: /[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}/ }

end
