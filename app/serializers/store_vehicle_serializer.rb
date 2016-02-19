class StoreVehicleSerializer < ActiveModel::Serializer
  attributes :id, :store_id, :store_chain_id, :store_staff_id, :store_customer_id,
    :vehicle_brand_id, :vehicle_model_id, :vehicle_series_id, :detail,
    :numero, :remark, :created_at, :updated_at, :license_number,
    :store_customer, :remark, :vin, :engine_num, :engine_id

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

  def engine_id
    if object.engines.present?
      object.engines.first.id
    else
      ""
    end
  end
end
