class StoreSubscribeOrderSerializer < ActiveModel::Serializer
  attributes :id

  has_one :store_vehicle
  has_one :store_customer
end
