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

class StoreVehicleSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :series, :model, :updated_at, :license_number
end
