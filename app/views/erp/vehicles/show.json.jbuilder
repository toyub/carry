json.vehicle do
  json.(@vehicle.plates.last, :license_number)
  json.(@vehicle.engines.last, :identification_number)
  json.(@vehicle.frame, :vin)
  json.(@vehicle, :numero)
  json.vehicle_brand @vehicle.vehicle_brand.name
  json.vehicle_model @vehicle.vehicle_model.name
  json.vehicle_series @vehicle.vehicle_series.name
  json.operator @vehicle.store_staff.full_name
  json.created_at @vehicle.created_at.strftime('%Y-%m-%d')
  json.detail do
    json.(@vehicle.detail,
      'color',
      'capacity',
      'organization_type',
      'bought_on',
      'ex_factory_date',
      'registered_on',
      'mileage'
      )
  end

  json.orders do
    json.array! @orders do |order|
      json.(order, :numero)
      json.created_at order.created_at.strftime('%Y-%m-%d')
      json.store_name order.store.name
      json.creator order.creator.full_name
      json.items order.items do |item|
        json.(item, :price, :quantity, :discount, :amount)
        json.mechanics ['王小勇', '李明亮']
        json.service_name "澜泰纳米镀晶"
      end
    end
  end

end
