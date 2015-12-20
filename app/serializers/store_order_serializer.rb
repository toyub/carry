class StoreOrderSerializer < ActiveModel::Serializer
  attributes :id, :numero

  has_one :store_vehicle
  has_one :store_customer
end
