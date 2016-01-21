module Entities
  class PackageAssetItem < Grape::Entity
    expose :id
    expose(:name) {|model| model.workflowable_hash['name']}
    expose :left_quantity
  end

  class ContainName < Grape::Entity
    expose(:name) {|model| model.workflowable_hash["name"]}
  end

  class PackageAsset < Grape::Entity
    expose :id, if: {type: :default}
    expose :package_name, if: {type: :default}
    expose(:bought_form, if: {type: :default}) {|model, options| model.store.name}
    expose(:use_for, if: {type: :default}) {|model| model.store.name + "等"}
    expose :contain_items, using: ContainName, if: {type: :default}
    expose :items, using: PackageAssetItem, if: {type: :default}

    expose(:created_at, if: {type: :full}) {|model| model.created_at.strftime("%Y-%m-%d")}
    expose(:numero, if: {type: :full}) {|model| model.store_order.numero}
    expose(:store_name, if: {type: :full}) {|model| model.store.name}

    expose :id, if: {type: :list}
    expose :package_name, if: {type: :list}

    private
    def contain_items
      object.items
    end
  end


end
