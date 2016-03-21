json.array! @material_saleinfos do |m|
  json.id m.store_material.id
  json.name m.store_material.name
  json.retail_price m.retail_price
  json.cost_price m.cost_price
end
