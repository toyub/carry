json.(@entity, :id, :telephone, :mobile, :qq, :province, :city, :region, :address, :range, :remark, :store_customer_category_id, :filling_date)
json.store_customer @entity.store_customer, :first_name, :last_name, :gender, :nick, :resident_id, :birthday, :married, :education, :profession, :income, :company, :tracking_accepted, :message_accepted
json.store_customer_settlement @entity.store_customer_settlement, :bank, :bank_account, :credit, :credit_amount, :notice_period, :contract, :tax, :payment_mode, :invoice_type, :invoice_title
json.cities Geo.cities(1, @entity.province)
json.regions Geo.regions(1, @entity.province, @entity.city)
