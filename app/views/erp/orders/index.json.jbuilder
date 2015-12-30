json.array! @orders do |order|
  json.(order, :numero)
  json.created_at order.created_at.strftime('%Y-%m-%d')
  json.store_name order.store.name
  json.creator order.creator.full_name
  json.items order.items do |item|
    json.(item, :price, :quantity, :discount, :amount)
    json.mechanics ['王小勇', '李明亮']
    json.service_name "澜泰纳米镀晶"
  end
end
