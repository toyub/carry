class StoreVehicleSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :license_number

  has_one :vehicle_brand
  has_one :vehicle_model
  has_one :vehicle_series
  has_one :store_customer
end
