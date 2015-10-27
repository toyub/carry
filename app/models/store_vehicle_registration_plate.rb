class StoreVehicleRegistrationPlate < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer
  belongs_to :store_vehicle
end

# == Schema Information
#
# Table name: store_vehicle_registration_plates
#
#  id                :integer          not null, primary key
#  store_id          :integer          not null
#  store_chain_id    :integer          not null
#  store_staff_id    :integer          not null
#  store_customer_id :integer          not null
#  license_number    :string(45)       not null
#  created_at        :datetime
#  updated_at        :datetime
#  store_vehicle_id  :integer
#
