class StoreSubscribeOrder < ActiveRecord::Base
  belongs_to :store_customer
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  belongs_to :store_vehicle, foreign_key: :vehicle_id

  enum state: %i[pending processing done]
  enum order_type: %i[auto]
end

# == Schema Information
#
# Table name: store_subscribe_orders
#
#  id                :integer          not null, primary key
#  store_id          :integer
#  store_chain_id    :integer
#  store_staff_id    :integer
#  remark            :string(255)
#  store_customer_id :integer
#  vehicle_id        :integer
#  subscribe_date    :datetime
#  state             :integer
#  order_type        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
