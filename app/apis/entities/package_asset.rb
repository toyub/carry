module Entities
  class Item < Grape::Entity
    expose :id
    expose(:name) {|model| model.workflowable_hash['name']}
    expose :left_quantity
  end

  class Contain < Grape::Entity
    expose(:name) {|model| model.workflowable_hash["name"]}
  end

  class PackageAssetItem < Grape::Entity

  end

  class PackageAsset < Grape::Entity
    expose :id, if: {type: :default}
    expose :package_name, if: {type: :default}
    # expose(:bought_form) {|model, options| model.store.name}
    expose(:bought_form, if: {type: :default}) {|model, options| model.store.name}
    expose(:use_for, if: {type: :default}) {|model| model.store.name + "等"}
    expose :contain_items, using: Contain, if: {type: :default}
    expose :items, using: Item, if: {type: :default}

    expose(:created_at) {|model| model.created_at.strftime("%Y-%m-%d")}
    expose(:numero) {|model| model.store_order.numero}
    expose(:store_name) {|model| model.store.name}

    private
    def contain_items
      object.items
    end
  end


end
