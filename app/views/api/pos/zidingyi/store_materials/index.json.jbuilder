json.array! @store_materials do |material|
  json.id           material.id
  json.name         material.name
  json.speci        material.speci

  json.store_material_unit do
    json.id         material.store_material_unit.id
    json.name       material.store_material_unit.name
  end
  json.store_material_saleinfo  do
    json.id         material.store_material_saleinfo.id
    json.name       material.store_material_saleinfo.name
  end

end
