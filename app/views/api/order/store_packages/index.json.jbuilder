json.array! @store_packages do |package|
  json.name package.name
  json.price package.price
  json.item package.package_setting.items
end
