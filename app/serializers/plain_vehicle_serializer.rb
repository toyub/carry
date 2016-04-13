class PlainVehicleSerializer < ActiveModel::Serializer
  attributes :id, :brand_name, :series_name, :vehicle_model_name, :license_number
end