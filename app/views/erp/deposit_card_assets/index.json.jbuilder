json.names @deposit_cards do |deposit_card|
  json.name deposit_card.items.first.assetable.name
end
