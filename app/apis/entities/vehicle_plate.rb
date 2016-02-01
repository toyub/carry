module Entities
  class VehiclePlate < Grape::Entity
    expose :store_customer_id, :license_number
    expose(:store_name) {|model| model.store.name}
    expose(:plate_id) {|model| model.id}
    expose(:customer_name) {|model| model.store_customer.full_name}
    expose(:phone_number) {|model| model.store_customer.try(:phone_number)}
    expose(:bought_on) {|model| model.store_vehicles.last.try(:detail).try(:bought_on,[])}
    expose(:barnd_name) {|model| model.store_vehicles.last.try(:vehicle_brand).try(:name)}
    expose(:series_name) {|model| model.store_vehicles.last.try(:vehicle_serie).try(:name)}
  end
end
