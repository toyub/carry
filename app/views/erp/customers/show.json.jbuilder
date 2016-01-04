json.customer do
  json.(@customer,
    :full_name,
    :gender,
    :nick,
    :telephone,
    :phone_number,
    :qq,
    :resident_id,
    :married,
    :profession,
    :income,
    :company,
    :education,
    :tracking_accepted,
    :message_accepted
  )
  json.created_at @customer.created_at.to_s
  json.age @customer.birthday && (Date.today - @customer.birthday).to_i/365
  json.birthday @customer.birthday.to_s
  json.property @customer.property_name
  json.category @customer.category_name
  json.province @customer.district['province']
  json.city @customer.district['city']
  json.region @customer.district['region']
  json.tags @customer.tags, :name
  json.(@customer.store_customer_entity, :range, :address)
  json.(@customer.store_customer_entity.store_customer_settlement,
    :bank,
    :bank_account,
    :invoice_type,
    :invoice_title,
    :notice_period,
    :tax,
    :contract,
    :payment_mode,
    :credit,
    :credit_limit,
  )
end
