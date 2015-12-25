json.array! @vehicles do |vehicle|
  json.history_service vehicle.orders do |order|
    json.created_at order.created_at.strftime('%Y-%m-%d')
    json.numero order.numero
    json.creator order.creator.full_name
    json.items order.items do |item|
      json.(@item, :price, :quantity, :amount)
      json.mechanics item.mechanics
      json.orderable_name item.orderable.name
      json.discount item.discount
    end
  end
  json.condition vehicle.orders do |order|
    json.created_at order.created_at.strftime('%Y-%m-%d')
    json.numero order.numero
    json.position order.position_name
    json.condition order.condition_name
  end
end
