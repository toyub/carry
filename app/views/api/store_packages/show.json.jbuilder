json.(@package, :id, :name, :code, :abstract, :remark, :sold_count)
json.uploads @package.uploads, :file_url
json.package_setting do
  json.id @package.package_setting.id
  json.items @package.package_setting.items, :id, :package_itemable_type, :package_itemable_id, :denomination, :price, :name, :quantity
end
json.trackings @package.trackings, :id, :mode, :notice_required, :content, :delay_unit, :delay_interval, :trigger_timing
json.order_items @order_items do |item|
  json.(item, :retail_price, :quantity, :discount, :amount)
  json.created_at item.created_at.strftime('%Y-%m-%d %H:%M')
  json.mechanics item.workflow_mechanics
  json.numero item.store_order.numero
  json.payment_methods item.store_order.payment_methods
  json.order_id item.store_order.id
end
