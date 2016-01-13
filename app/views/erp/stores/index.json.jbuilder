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
end
