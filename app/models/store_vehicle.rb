class StoreVehicle < ActiveRecord::Base
  include BaseModel

  belongs_to :brand, class_name: "StoreVehicleBrand", foreign_key: :store_vehicle_brand_id

  has_one :engine, class_name: "StoreVehicleEngine", foreign_key: :store_vehicle_id
  has_one :frame, class_name: "StoreVehicleFrame", foreign_key: :store_vehicle_id
  has_one :registration_plate, class_name: "StoreVehicleRegistrationPlate", foreign_key: :store_vehicle_id
end
