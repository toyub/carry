json.array! @vehicles do |vehicle|
  json.basic_info do
    json.(vehicle.plates.last, :license_number)
    json.(vehicle.engines.last, :identification_number)
    json.(vehicle.frame, :vin)
    json.(vehicle, :id)
    json.vehicle_brand vehicle.vehicle_brand.name
    json.vehicle_model vehicle.vehicle_model.name
    json.vehicle_series vehicle.vehicle_series.name
    json.operator vehicle.store_staff.full_name
    json.created_at vehicle.created_at.strftime('%Y-%m-%d')
    json.(vehicle.detail,
      'color',
      'capacity',
      'organization_type',
      'bought_on',
      'ex_factory_date',
      'registered_on',
      'mileage'
    )
  end

  json.detail do
    json.(vehicle.detail,
      'numero',
      'maintained_at',
      'maintained_mileage',
      'maintain_interval_time',
      'maintain_interval_mileage',
      'next_maintain_mileage',
      'next_maintain_at',
      'annual_check_at',
      'insurance_compnay',
      'insurance_expire_at',
      'next_maintain_customer_alermify',
      'next_maintain_store_alermify',
      'annual_check_customer_alermify',
      'annual_check_store_alermify',
      'insurance_customer_alermify',
      'insurance_store_alermify'
    )
  end

  json.conditions vehicle.orders do |order|

  end

  json.orders vehicle.orders do |order|
    json.(order, :numero)
    json.created_at order.created_at.strftime('%Y-%m-%d')
    json.store_name order.store.name
    json.creator order.creator.full_name
    json.items order.items do |item|
      json.(item, :price, :quantity, :discount, :amount)
      json.mechanics ['王小勇', '李明亮']
      json.name "澜泰纳米镀晶"
    end
  end

end
