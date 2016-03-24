module Entities
  class StoreCustomerInfo < Grape::Entity
    expose :full_name, :id, :phone_number
    expose :entity, using: StoreCustomerEntityInfo

    private
    def entity
      object.store_customer_entity
    end
  end

  class VehiclePlate < Grape::Entity
    expose :license_number, :vehicle_id
    expose(:store_customer_id) {|model|model.vehicle_plates.last.store_vehicle.store_customer_id}
    expose(:store_name) {|model| model.store.name}
    expose(:plate_id) {|model| model.id}
    expose(:customer_name) {|model| model.store_customer.try(:full_name)}
    expose(:phone_number) {|model| model.store_customer.try(:phone_number)}
    expose(:bought_on) {|model| model.current_vehicle.try(:detail).try(:bought_on,[])}
    expose(:barnd_name) {|model| model.current_vehicle.try(:vehicle_brand).try(:name)}
    expose(:series_name) {|model| model.current_vehicle.try(:vehicle_series).try(:name)}
    expose(:model_name) {|model| model.current_vehicle.try(:vehicle_model).try(:name)}
    expose(:vip) {|model| model.store_customer.try(:store_customer_entity).try(:membership) == true ? true : false}
    expose :customer, using: StoreCustomerInfo

    private
    def customer
      object.store_customer
    end
  end
end
