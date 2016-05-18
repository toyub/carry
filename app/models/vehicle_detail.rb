class VehicleDetail
   include ActiveModel::Model
   attr_accessor :numero, :organization_type, :bought_on, :ex_factory_date, :maintained_at,
                 :maintained_mileage, :maintain_interval_time, :maintain_interval_mileage,
                 :next_maintain_mileage, :next_maintain_at, :color, :capacity, :registered_on,
                 :mileage, :annual_check_at, :insurance_expire_at, :next_maintain_customer_alermify,
                 :next_maintain_store_alermify, :annual_check_customer_alermify, :annual_check_store_alermify,
                 :insurance_customer_alermify, :insurance_store_alermify
end