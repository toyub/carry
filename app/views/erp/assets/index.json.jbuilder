json.deposit_card_assets do
  json.count @deposit_cards.count
  json.names @deposit_cards, :package_name
end

json.package_assets do
  json.count @packages.count
  json.packages @packages, :id, :package_name
end

json.material_assets do
  json.count @materials.count
  json.materials @materials, :id, :package_name
end
