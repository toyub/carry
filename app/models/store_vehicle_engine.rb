class StoreVehicleEngine < ActiveRecord::Base
  include BaseModel

  belongs_to :creator, class_name: 'StoreStaff', foreign_key: :store_staff_id
  belongs_to :store_vehicle
end

# == Schema Information
#
# Table name: store_vehicle_engines
#
#  id                    :integer          not null, primary key
#  created_at            :datetime
#  updated_at            :datetime
#  store_id              :integer          not null
#  store_chain_id        :integer          not null
#  store_staff_id        :integer          not null
#  identification_number :string(45)
#  store_vehicle_id      :integer
#  store_customer_id     :integer
#
