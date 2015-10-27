class StoreOrder < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id
  belongs_to :store_vehicle

  enum state: %i[pending processing waiting_pay paid]
end

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
