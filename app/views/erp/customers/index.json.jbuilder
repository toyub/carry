json.array! @customers do |customer|
  json.(customer, :id, :full_name, :telephone)
  json.(customer.store_customer_entity, :property)
  json.store_name customer.store.name
  json.category customer.category_name
  json.vehicle_count customer.vehicle_count
  json.consume_times customer.consume_times
  json.consume_total customer.consume_total
  json.credits customer.credits
  json.integrity customer.integrity
  json.activeness customer.activeness
  json.satisfaction customer.satisfaction
  json.operator customer.store_staff.full_name
end
