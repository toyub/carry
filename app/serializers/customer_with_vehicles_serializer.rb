class CustomerWithVehiclesSerializer < ActiveModel::Serializer
  attributes :id, :full_name
  has_many :store_vehicles, serializer: PlainVehicleSerializer
end