class StoreVehicleSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :series, :model, :updated_at, :name

  def name
    object.registration_plate.license_number
  end
end
