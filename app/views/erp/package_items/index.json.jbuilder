json.array! @logs do |log|
  json.created_at log.created_at.strftime('%Y-%m-%d')
  json.(log.store_order, :numero)
  json.store_name log.store.name
end
