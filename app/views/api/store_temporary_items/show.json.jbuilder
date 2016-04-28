json.(@temporary_item, :id, :quantity, :has_purchased_quantity)
json.material do
  json.id @temporary_material.id
  json.name @temporary_material.name
  json.barcode @temporary_material.barcode
  json.speci @temporary_material.speci
  json.unit @temporary_material.store_material_unit.try(:name)
  json.root_category @temporary_material.store_material_root_category.try(:name)
  json.category @temporary_material.store_material_category.try(:name)
end

