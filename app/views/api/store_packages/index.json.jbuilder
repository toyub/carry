json.array! @packages do |package|
  json.(package, :id, :name, :code, :abstract, :remark, :price, :vip_price)
  json.package_setting do
    json.id package.package_setting.id
    json.period package.package_setting.period
    json.period_unit package.package_setting.period_unit
    json.point package.package_setting.point
    json.retail_price package.package_setting.retail_price
  end
  json.quantity 1
  json.recommended_price 0
end
