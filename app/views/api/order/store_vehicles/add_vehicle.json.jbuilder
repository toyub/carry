json.customer do
  json.full_name @customer.full_name
  json.phone_number @customer.phone_number
end
json.plate do
  json.license_number @customer.plates.last.try(:license_number)
end
json.vehicle do
  json.bought_on @customer.vehicle_bought
  json.brand_name @customer.brand_name
end
json.status @status
json.info @info
