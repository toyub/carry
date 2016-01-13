json.customer do
  json.full_name @plate.store_customer.full_name
  json.license_number @plate.license_number
  json.phone_number @plate.store_customer.phone_number
end
json.materials do
  json.array! @sale_category do |category|
    json.name category.name
    json.id category.id
  end
end
json.services do
  json.array! @service_category do |category|
    json.name category.name
    json.id category.id
  end
end
