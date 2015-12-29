json.array! @orders do |order|
  json.(order, :numero, :amount_total)
  json.created_at order.created_at.strftime('%Y-%m-%d')
  json.store_name order.store.name
  json.creator order.creator.full_name
  json.items order.items do |item|
    json.(item, :price, :quantity, :discount, :amount)
    json.creator item.creator.full_name
    json.orderable_name item.orderable.name
  end
end
