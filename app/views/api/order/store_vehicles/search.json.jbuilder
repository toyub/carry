json.array! @plates do |plate|
  json.store_id plate.store.try(:id)
  json.store_name plate.store.try(:name)
  json.store_customer_id plate.store_customer.try(:id)
  json.plate_id plate.id
  json.license_number plate.license_number
  json.customer_name plate.store_customer.try(:full_name)
  json.phone_number plate.store_customer.try(:phone_number)
  json.bought_on plate.store_vehicles.last.try(:detail).try(:bought_on,[])
  json.barnd_name plate.store_vehicles.last.try(:vehicle_brand).try(:name)
  json.serie_name plate.store_vehicles.last.try(:vehicle_serie).try(:name)
end
