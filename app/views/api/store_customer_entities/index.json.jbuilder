json.array! @entities do |entity|
  json.(entity, :id, :region, :address, :remark, :property_i18n, :property, :store_customer_category_id)
  json.store_customer entity.store_customer, :phone_number, :full_name, :operator
end
