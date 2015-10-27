# == Schema Information
#
# Table name: store_orders
#
#  id                :integer          not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  store_id          :integer          not null
#  store_chain_id    :integer          not null
#  store_staff_id    :integer          not null
#  amount            :decimal(12, 4)   default(0.0)
#  remark            :string(255)
#  store_customer_id :integer
#  store_vehicle_id  :integer
#  state             :integer
#

class StoreOrderSerializer < ActiveModel::Serializer
  attributes :id

  has_one :store_vehicle
  has_one :store_customer
end
