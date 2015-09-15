class StoreVehicle < ActiveRecord::Base
  include BaseModel

  belongs_to :brand, class_name: "StoreVehicleBrand", foreign_key: :store_vehicle_brand_id
  belongs_to :creator, class_name: 'StoreStaff', foreign_key: :store_staff_id

  has_one :engine, class_name: "StoreVehicleEngine"
  has_one :frame, class_name: "StoreVehicleFrame"
  has_one :registration_plate, class_name: "StoreVehicleRegistrationPlate"
  has_many :orders, class_name: "StoreOrder"
end
