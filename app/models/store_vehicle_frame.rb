class StoreVehicleFrame < ActiveRecord::Base
  include BaseModel

end

# == Schema Information
#
# Table name: store_vehicle_frames
#
#  id                :integer          not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  store_id          :integer          not null
#  store_chain_id    :integer          not null
#  store_staff_id    :integer          not null
#  vin               :string(45)
#  store_vehicle_id  :integer
#  store_customer_id :integer
#
