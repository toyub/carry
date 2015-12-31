json.vehicle do
  json.(@vehicle.plates.last, :license_number)
  json.(@vehicle.engines.last, :identification_number)
  json.(@vehicle.frame, :vin)
  json.(@vehicle, :id, :numero)
  json.vehicle_brand @vehicle.vehicle_brand.name
  json.vehicle_model @vehicle.vehicle_model.name
  json.vehicle_series @vehicle.vehicle_series.name
  json.operator @vehicle.store_staff.full_name
  json.created_at @vehicle.created_at.strftime('%Y-%m-%d')

  json.detail do
    @vehicle.detail.each do |key, value|
      json.set! key, value
    end
    json.organization_type @vehicle.organization_type_name
  end
end
