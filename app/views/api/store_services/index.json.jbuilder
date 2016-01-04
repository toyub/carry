json.array! @services do |service|
  json.(service, :id, :name, :code, :bargain_price, :point, :retail_price)
end
