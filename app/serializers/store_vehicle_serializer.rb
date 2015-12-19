class StoreVehicleSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :series, :model, :updated_at, :license_number

  has_one :brand
  has_one :store_customer
end
