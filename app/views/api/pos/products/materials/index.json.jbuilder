json.array! @materials do |material|
  json.(material, :id, :name, :speci, :inventory, :reward_points,
                  :service_needed, :service_fee, :service_fee_needed,
                  :retail_price, :vip_price, :vip_price_enabled, :bargainable, :bargain_price, :trade_price,
                  :divide_to_retail, :divide_unit_type_id, :divide_total_volume, :divide_volume_per_bill)
  json.store_material_root_category_id material.store_material.store_material_root_category_id
  json.store_material_category_id material.store_material.store_material_category_id
  json.category_name material.sale_category.try :name
  json.services material.services.not_deleted, :id, :name, :mechanic_level_type, :work_time, :work_time_in_seconds, :work_time_unit, :quantity
end
