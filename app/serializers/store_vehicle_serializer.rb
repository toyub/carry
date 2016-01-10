class StoreVehicleSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :license_number, :store_customer

  has_one :vehicle_brand
  has_one :vehicle_model
  has_one :vehicle_series
  
  def store_customer
    StoreCustomerSerializer.new(object.store_customer).as_json(root: nil)
  end
end
