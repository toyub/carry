json.array! @orders do |order|
  json.(order, :numero, :amount_total)
  json.created_at order.created_at.strftime('%Y-%m-%d')
  json.store_name order.store.name
  json.creator order.creator.full_name
  json.items order.items do |item|
    json.(item, :price, :quantity, :amount)
    # json.creator item.creator.full_name
    json.mechanics item.mechanics
    json.orderable_name item.orderable.name
    json.discount item.discount
  end
end
