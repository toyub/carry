json.array! @customers do |customer|
  json.(customer, :id, :full_name, :telephone)
  json.property customer.property
  json.category customer.category
  json.store_name customer.store.name
  json.vehicle_count customer.vehicle_count
  json.consume_times customer.consume_times
  json.consume_total customer.consume_total
  json.integrity customer.integrity
  json.activeness customer.activeness
  json.satisfaction customer.satisfaction
  json.creator customer.creator.full_name
  json.(customer.store_customer_entity, :points)
end
