json.(@package, :id, :name, :code, :abstract, :remark)
json.uploads @package.uploads, :file_url
json.package_setting do
  json.id @package.package_setting.id
  json.items @package.package_setting.items, :id, :package_itemable_type, :package_itemable_id, :denomination, :price, :name, :quantity
end
json.trackings @package.trackings, :id, :mode, :notice_required, :content, :delay_unit, :delay_interval, :trigger_timing
