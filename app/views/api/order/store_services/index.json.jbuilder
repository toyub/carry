json.array! @services do |service|
  json.name service.name
  json.retail_price service.retail_price
  json.bargain_price service.bargain_price
end
