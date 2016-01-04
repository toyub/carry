json.customer do
  json.(@customer,
    :full_name,
    :gender,
    :nick,
    :telephone,
    :phone_number,
    :qq,
    :resident_id,
    :created_at,
    :married,
    :profession,
    :income,
    :company,
    :tracking_accepted,
    :message_accepted
  )
  json.age @customer.birthday && (Date.today - @customer.birthday).to_i/365
  json.birthday @customer.birthday.to_s
  json.property @customer.property_name
  json.category @customer.category_name
  json.province @customer.district['province']
  json.city @customer.district['city']
  json.region @customer.district['region']
  json.tags @customer.tags, :name
  json.(@customer.store_customer_entity, :range)
end
