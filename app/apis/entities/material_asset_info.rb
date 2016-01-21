module Entities
  class MaterialAssetInfo < Grape::Entity
    expose :package_name
    expose(:created_at) { |asset, options| asset.created_at.strftime('%Y-%m-%d') }
    expose(:bought_from) { |asset, options| asset.store.name }
    expose(:use_for) { |asset, options| asset.store.name + '等' }
    expose :contain_items do |asset, options|
      asset.items.map do |item|
        { name: item.workflowable_hash['name'] }
      end
    end
    expose :items do |asset, options|
      asset.items.map do |item|
        {
          id: item.id,
          name: item.workflowable_hash['name'],
          left_quantity: item.left_quantity
        }
      end
    end
  end
end
