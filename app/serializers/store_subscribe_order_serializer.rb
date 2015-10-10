class StoreSubscribeOrderSerializer < ActiveModel::Serializer
  attributes :id, :subscribe_date, :order_type

  has_one :store_vehicle
  has_one :store_customer

  def subscribe_date
    object.subscribe_date.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end

  def order_type
    I18n.t("enums.store_subscribe_order.order_type.#{object.order_type}")
  end
end
