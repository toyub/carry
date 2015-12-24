json.array! @stores do |store|
  json.(store, :id, :name)
  json.customer_categories store.store_customer_categories, :id, :name
end
