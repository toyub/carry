module Entities
  class DepositCardAsset < Grape::Entity
    expose :name do |deposit_card, options|
      deposit_card.items.first.assetable.try(:name)
    end
  end
end
