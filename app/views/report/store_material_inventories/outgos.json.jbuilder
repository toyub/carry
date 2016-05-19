json.outgos @outgos do |out|
  json.(out, :accruals, :chain_business_model_id, :closings, :format_created_at, :created_month, :id, :openings, :store_depot)
  json.logged_item do
    json.created_at out.logged_item.format_created_at
    json.numero out.logged_item.numero
  end
  json.store_material do
    json.speci out.store_material.speci
    json.name out.store_material.name
    json.barcode out.store_material.barcode
    json.store_material_unit out.store_material.store_material_unit
    json.store_material_brand out.store_material.store_material_brand
  end
end
