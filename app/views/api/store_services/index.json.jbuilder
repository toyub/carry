json.array! @services do |service|
  json.(service, :id, :name, :code, :bargain_price, :point, :retail_price,
        :standard_time, :quantity, :vip_price, :engineer_level, :category_name)
  json.recommended_price 0
end
