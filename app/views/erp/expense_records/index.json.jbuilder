json.array! @orders do |order|
  json.created_at order.created_at.strftime('%Y-%m-%d')
  json.numero order.numero
  json.store_name order.store.name
  json.creator order.creator.full_name
  json.items order.items do |item|
    json.creator item.creator.full_name
    json.subject item.orderable.name
    json.price item.price
    json.quantity item.quantity
    json.discount 0
    json.amount item.amount
  end
  json.amount_total order.amount_total
end
