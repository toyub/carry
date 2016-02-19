json.array! @packages do |package|
  json.(package, :id, :name, :code, :abstract, :remark, :price, :vip_price, :retail_price)
    
  json.period package.package_setting.period
  json.period_unit package.package_setting.period_unit
  json.point package.package_setting.point
  json.contains_service package.package_setting.contains_service

  json.services package.package_setting.services do |service|
    json.id service.id
    json.name service.package_itemable.name
    json.quantity service.quantity
    json.work_time service.package_itemable.time
    json.mechanic_level service.package_itemable.engineer_level
  end
  
  json.quantity 1
  json.recommended_price 0
end
