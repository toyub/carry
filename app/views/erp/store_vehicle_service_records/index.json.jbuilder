json.vehicle do
  json.(@vehicle.plates.last, :license_number)
  json.(@vehicle.frame, :vin)
  json.(@vehicle.engines.last, :identification_number)
  json.(@vehicle, :numero)
  json.vehicle_brand @vehicle.vehicle_brand.name
  json.vehicle_model @vehicle.vehicle_model.name
  json.vehicle_series @vehicle.vehicle_series.name
  json.staff_name @vehicle.store_staff.full_name
  json.created_at @vehicle.created_at.strftime('%Y-%m-%d')
  json.integrity @vehicle.try(:integrity)

  json.detail do
    json.organization_type @vehicle.organization_type_name
    json.color @vehicle.detail['color']
    json.capacity @vehicle.detail['capacity']
    json.bought_on @vehicle.detail['bought_on']
    json.ex_factory_date @vehicle.detail['ex_factory_date']
    json.registered_on @vehicle.detail['registered_on']
    json.mileage @vehicle.detail['mileage']
  end

  json.orders @vehicle.orders do |order|
    json.created_at order.created_at.strftime('%Y-%m-%d')
    json.numero order.numero
    json.creator order.creator.full_name
    json.items order.items do |item|
      json.(@item, :price, :quantity, :amount)
      json.mechanics item.mechanics
      json.orderable_name item.orderable.name
      json.discount item.youhui
    end
  end
end
