json.(@customer,
  :full_name,
  :gender,
  :nick,
  :telephone,
  :phone_number,
  :qq,
  :resident_id,
  :married,
  :company,
  :tracking_accepted,
  :message_accepted
)
json.profession @customer.profession_name
json.income @customer.income
json.education @customer.education
json.created_at @customer.created_at.to_s
json.age @customer.age
json.birthday @customer.birthday.to_s
json.property @customer.property
json.category @customer.category
json.province @customer.district['province']
json.city @customer.district['city']
json.region @customer.district['region']
json.credit @customer.credit
json.notice_period @customer.notice_period
json.payment_mode @customer.payment_mode
json.invoice_type @customer.invoice_type
json.tags @customer.tags, :name
json.(@customer.store_customer_entity, :range, :address, :remark)
json.(@customer.store_customer_entity.store_customer_settlement,
  :bank,
  :bank_account,
  :invoice_title,
  :tax,
  :contract,
  :credit_limit
)
