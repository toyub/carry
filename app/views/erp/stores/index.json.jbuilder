json.array! @stores do |store|
  json.(store, :id, :name)
  json.customer_categories store.store_customer_categories, :id, :name
  json.commission StoreStaffLevel::ID_TYPES
  json.departments store.store_departments do |department|
    json.id department.id
    json.name department.name
    json.positions department.store_positions.each do |position|
      json.id position.id
      json.name position.name
    end
  end

  json.province store.province
  json.city store.city
  json.admin store.admin.try(:full_name)
  json.phone_number store.admin.try(:phone_number)
  json.address store.address
  json.created_at store.created_at.strftime('%Y-%m-%d')
  json.(store, :business_status)
  json.business_hours store.business_hours
  json.last_year_sales store.last_year_sales
  json.current_year_sales store.current_year_sales
end
