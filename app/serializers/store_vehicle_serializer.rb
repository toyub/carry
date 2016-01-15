class StoreVehicleSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :license_number, :store_customer, :bought_on,
    :ex_factory_date, :registered_on, :mileage, :next_maintain_mileage, :next_maintain_at,
    :remark, :vin, :engine_num

  has_one :vehicle_brand
  has_one :vehicle_model
  has_one :vehicle_series

  def store_customer
    StoreCustomerSerializer.new(object.store_customer).as_json(root: nil)
  end

  def vin
    object.frame.try(:vin)
  end

  def engine_num
    if object.engines.present?
      object.engines.first.identification_number
    else
      ""
    end
  end
end
