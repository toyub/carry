json.customer do
  json.id @customer.id
  json.full_name @customer.full_name
  json.assets @customer.assets.serviceable do |asset|
    json.id asset.id
    json.package_name asset.package_name
    json.items asset.items, :id, :total_quantity, :used_quantity, :name
  end
end
