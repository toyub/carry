module Entities
  class StoreVehicle < Grape::Entity
    expose :id, :license_number
    expose(:phone_number) {|store_vehicle| store_vehicle.store_customer.phone_number }
    expose(:brand) {|store_vehicle| store_vehicle.brand_name }
    expose(:series_name) {|store_vehicle| store_vehicle.series_name }
  end
end
