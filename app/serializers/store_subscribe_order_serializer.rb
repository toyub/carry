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

class StoreSubscribeOrderSerializer < ActiveModel::Serializer
  attributes :id, :subscribe_date, :order_type, :state, :remark

  has_one :store_vehicle
  has_one :store_customer

  def subscribe_date
    object.subscribe_date.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end

  def order_type
    I18n.t("enums.store_subscribe_order.order_type.#{object.order_type}")
  end

  def state
    I18n.t("enums.store_subscribe_order.state.#{object.state}")
  end
end
