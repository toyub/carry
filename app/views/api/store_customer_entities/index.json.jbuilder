json.array! @entities do |entity|
  json.(entity, :id, :region, :address, :remark, :property)
  json.store_customer entity.store_customer, :phone_number, :full_name, :operator
end
