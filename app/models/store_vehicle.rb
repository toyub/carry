class StoreVehicle < ActiveRecord::Base
  include BaseModel

  belongs_to :vehicle_brand
  belongs_to :vehicle_model
  belongs_to :vehicle_series

  # 车牌
  has_many :vehicle_plates
  has_many :plates, through: :vehicle_plates

  # 发动机
  has_many :vehicle_engines
  has_many :engines, through: :vehicle_engines

  # 车架
  has_one :frame, class_name: "StoreVehicleFrame"

  has_many :orders, class_name: "StoreOrder"

  delegate :license_number, to: :registration_plate

  accepts_nested_attributes_for :vehicle_plates
  # accepts_nested_attributes_for :store_vehicle_registration_plates
  accepts_nested_attributes_for :vehicle_brand
  accepts_nested_attributes_for :vehicle_engines
end
