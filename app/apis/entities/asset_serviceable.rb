module Entities
  class AssetServiceableItem < Grape::Entity
    expose(:asset_item_id) {|model|model.id}
    expose(:created_at) {|model|model.created_at.to_s(:date_only)}
    expose :service, :assetable_type, :assetable_id, :orderable_type,
           :orderable_id, :total_quantity, :used_quantity, :name
  end

  class AssetServiceable < Grape::Entity
    expose :id, :package_name
    expose :available_items, using: AssetServiceableItem
  end

end
