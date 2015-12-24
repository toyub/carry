json.array! @customers do |customer|
  json.(customer, :id, :full_name, :telephone)
  json.store_name customer.store.name
  json.property customer.store_customer_entity.property
  json.category customer.category_name
  json.vehicle_count customer.vehicle_count
  json.consume_times customer.try(:consume_times)
  json.consume_total customer.try(:consume_total)
  json.credits customer.try(:credits)
  json.integrity customer.try(:integrity)
  json.activeness customer.try(:activeness)
  json.satisfaction customer.try(:satisfaction)
  json.operator customer.store_staff.full_name
end
