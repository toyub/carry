# json.customer do
#   json.(@customer,
#     :full_name,
#     :gender,
#     :phone_number,
#     :qq,
#     :resident_id,
#     :created_at,
#     :married,
#     :profession,
#     :income,
#     :company,
#     :tracking_accepted,
#     :message_accepted
#   )
#   json.age (Date.today - @customer.birthday)/365
#   json.birthday @customer.birthday.strftime('%Y-%m-%d')
#   json.property @customer.property_name
#   json.category @customer.category_name
#   json.province @customer.district['province']
#   json.city @customer.district['city']
#   json.region @customer.district['region']
#   json.tags @customer.tags, :name
#   json.(@customer.store_customer_entity, :range)
# end
