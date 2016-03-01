class StoreVehicleRegistrationPlate < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer

  has_many :orders, class_name: 'StoreOrder'

  # 车牌
  has_many :vehicle_plates
  has_many :store_vehicles, through: :vehicle_plates

  validates :license_number, presence: true, uniqueness: { scope: :store_id }, length: { in: 7..8 }
  validates :license_number, format: { with: /\A\S[\u4e00-\u9fa5_A-Za-z\d]+\S\z/ }

  def vehicle_id
    vehicle_plates.last.store_vehicle.id
  end

  def store_customer
    vehicle_plates.last.store_vehicle.store_customer
  end


end
