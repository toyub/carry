json.customer do
  json.id @customer.id
  json.full_name @customer.full_name
  json.assets @customer.available_orderable_assets do |asset|
    json.id asset.id
    json.package_name asset.package_name
    json.items asset.available_items, :id, :total_quantity, :used_quantity, :name, :assetable_type, :assetable_id, :service, :orderable_type, :orderable_id
    json.created_at asset.created_at.to_s(:date_only)
  end
end
