json.(@entity, :id, :telephone, :mobile, :qq, :district, :address, :range, :remark, :store_customer_category_id)
json.store_customers @entity.store_customers, :first_name, :last_name, :gender, :nick, :resident_id, :birthday, :married, :education, :profession, :income, :company, :tracking_accepted, :message_accepted
json.store_customer_settlement @entity.store_customer_settlement, :bank, :bank_account, :credit, :credit_amount, :notice_period, :contract, :tax, :payment_mode, :invoice_type, :invoice_title
