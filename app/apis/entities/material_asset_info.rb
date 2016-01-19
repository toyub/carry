module Entities
  class MaterialAssetInfo < Grape::Entity
    expose :package_name
    expose :created_at do |asset, options|
      asset.created_at.strftime('%Y-%m-%d')
    end
    expose :bought_from do |asset, options|
      asset.store.name
    end
    expose :use_for do |asset, options|
      asset.store.name + '等'
    end
    expose :contain_items do |asset, options|
      asset.items.map{ |item| item.workflowable_hash['name'] }
    end
    expose :items do |asset, options|
      asset.items do |item|
        {
          id: item.id,
          name: item.workflowable_hash['name'],
          left_quantity: item.left_quantity
        }
      end
    end
  end
end
