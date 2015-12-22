json.array! @customers do |customer|
  json.full_name customer.full_name
  json.store_name customer.store_name
  json.telephone customer.telephone
  json.property customer.property_name
  json.category customer.category_name
  json.vehicle_count customer.vehicle_count
  json.consume_times customer.try(:consume_times)
  json.consume_total customer.try(:consume_total)
  json.credits customer.try(:credits)
  json.integrity customer.try(:integrity)
  json.activeness customer.try(:activeness)
  json.satisfaction customer.try(:satisfaction)
  json.operator customer.store_staff_name
end
