json.(@package_asset, :package_name)
json.created_at @package_asset.created_at.strftime('%Y-%m-%d')
json.bought_from @package_asset.store.name
json.use_for @package_asset.store.name + '等'
json.contain_items @items.first.workflowable_hash['name']
if @items.count > 1
  json.contain_items @items.first.workflowable_hash['name'].concat("等#{@items.count}个项目")
end
json.items @items do |item|
  json.name item.workflowable_hash['name']
  json.left_quantity item.left_quantity
end
