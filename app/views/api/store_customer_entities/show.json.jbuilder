json.(@entity, :id, :qq, :province, :property_i18n, :property, :city, :region, :address, :range, :remark, :store_customer_category_id, :filling_date)
json.store_customer do
  json.(@entity.store_customer, :id, :first_name, :last_name, :full_name, :phone_number, :qq, :telephone, :gender, :nick, :resident_id, :birthday, :married, :education, :profession,
                                :income, :company, :tracking_accepted, :message_accepted, :operator, :age,
                                :vehicles_count, :orders_count, :total_amount, :has_customer_asset, :integrity, :activeness, :first_vehicle_id)
  json.tags @entity.store_customer.tags, :id, :name
end
json.store_customer_settlement @entity.store_customer_settlement, :id, :bank, :bank_account, :credit, :credit_limit, :notice_period, :contract, :tax, :payment_mode, :invoice_type, :invoice_title, :contact
json.cities Geo.cities(1, @entity.province), :code, :name
json.regions Geo.regions(1, @entity.province, @entity.city), :code, :name
