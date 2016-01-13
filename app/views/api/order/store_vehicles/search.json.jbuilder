json.array! @plates do |plate|
  json.store_id plate.store.id
  json.store_name plate.store.name
  json.store_customer_id plate.store_customer.id
  json.plate_id plate.id
  json.license_number plate.license_number
  json.customer_name plate.store_customer.full_name
  json.phone_number plate.store_customer.phone_number
  json.bought_on plate.store_vehicles.last.detail["bought_on"]
  json.barnd_name plate.store_vehicles.last.try(:vehicle_brand).try(:name)
end
