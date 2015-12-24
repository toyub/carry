json.array! @vehicles do |vehicle|
  json.(vehicle.plates.last, :license_number)
  json.(vehicle.engines.last, :identification_number)
  json.(vehicle.frame, :vin)
  json.(vehicle, :numero)
  json.vehicle_brand vehicle.vehicle_brand.name
  json.vehicle_model vehicle.vehicle_model.name
  json.vehicle_series vehicle.vehicle_series.name
  json.staff_name vehicle.store_staff.full_name
  json.created_at vehicle.created_at.strftime('%Y-%m-%d')

  json.detail do
    vehicle.detail.each do |detail|
      json.set! detail.first, detail.last
    end
    json.organization_type vehicle.organization_type_name
  end
end
