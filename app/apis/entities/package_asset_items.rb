module Entities
  class Item < Grape::Entity
    expose :id
    expose(:name) {|model| model.workflowable_hash['name']}
    expose :left_quantity
  end

  class Fuck < Grape::Entity
    expose(:name) {|model| model.workflowable_hash["name"]}
  end

  class PackageAssetItems < Grape::Entity
    expose :id
    expose :package_name
    expose(:bought_form) {|model| model.store.name }
    expose(:use_for) {|model| model.store.name + "等"}
    expose :contain_items, using: Fuck
    expose :items, using: Item

    private
    def contain_items
      object.items
    end
  end


end
