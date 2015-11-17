class StoreVehicle < ActiveRecord::Base
  include BaseModel

  belongs_to :brand, class_name: "StoreVehicleBrand", foreign_key: :store_vehicle_brand_id

  has_one :engine, class_name: "StoreVehicleEngine"
  has_one :frame, class_name: "StoreVehicleFrame"
  has_one :registration_plate, class_name: "StoreVehicleRegistrationPlate"
  has_many :orders, class_name: "StoreOrder"

  delegate :license_number, to: :registration_plate
end

# == Schema Information
#
# Table name: store_vehicles
#
#  id                     :integer          not null, primary key
#  created_at             :datetime
#  updated_at             :datetime
#  store_id               :integer          not null
#  store_chain_id         :integer          not null
#  store_staff_id         :integer          not null
#  model                  :string(45)
#  series                 :string(45)
#  store_vehicle_brand_id :integer
#  store_customer_id      :integer
#
