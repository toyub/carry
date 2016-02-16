json.array! @materials do |material|
  json.(material, :id, :name, :speci, :inventory, :reward_points,
                  :service_needed, :service_fee, :service_fee_needed,
                  :retail_price, :vip_price, :vip_price_enabled, :bargainable, :bargain_price, :trade_price,
                  :divide_to_retail, :divide_unit_type_id, :divide_total_volume, :divide_volume_per_bill)
  json.category_name material.sale_category.try :name
  json.recommended_price 0
  json.services material.services, :id, :name, :mechanic_level, :work_time, :work_time_in_seconds, :work_time_unit, :quantity
end
