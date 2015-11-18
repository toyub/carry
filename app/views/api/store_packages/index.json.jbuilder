json.array! @packages do |package|
  json.(package, :id, :name, :code, :abstract, :remark)
  json.package_setting do
    json.id package.package_setting.id
    json.period package.package_setting.period
    json.period_unit package.package_setting.period_unit
    json.point package.package_setting.point
  end
end
