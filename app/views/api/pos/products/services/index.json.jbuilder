json.array! @services do |service|
  json.(service, :id, :category_id, :name, :category_name, :retail_price, :bargain_price, :bargain_price_enabled, :vip_price_enabled, :time, :point)
end
