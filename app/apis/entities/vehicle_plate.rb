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
    expose :license_number
    expose(:vehicle_id){|model| model.id}
    expose(:store_customer_id) {|model|model.store_customer.id}
    expose(:store_name) {|model| model.store.name}
    expose(:customer_name) {|model| model.store_customer.full_name}
    expose(:phone_number) {|model| model.store_customer.phone_number}
    expose(:bought_on) {|model| model.detail.try(:bought_on,[])}
    expose(:barnd_name) {|model| model.vehicle_brand.try(:name)}
    expose(:series_name) {|model| model.vehicle_series.try(:name)}
    expose(:model_name) {|model| model.vehicle_model.try(:name)}
    expose(:vip) {|model| model.store_customer.store_customer_entity.membership }
    expose :customer, using: StoreCustomerInfo

    private
    def customer
      object.store_customer
    end
  end
end
