json.array! @stores do |store|
  json.(store, :id, :name)
  json.customer_categories store.store_customer_categories, :id, :name

  json.province store.province
  json.city store.city
  json.admin store.admin.full_name
  json.(store.admin, :phone_number)
  json.address store.address
  json.created_at store.created_at.strftime('%Y-%m-%d')
  json.(store, :business_status)
  json.business_hours store.business_hours
  json.last_year_sales store.last_year_sales
  json.current_year_sales store.current_year_sales
end
