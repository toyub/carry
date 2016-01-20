module Entities
  class PackageAssetItem < Grape::Entity
    expose(:created_at) {|model| model.created_at.strftime("%Y-%m-%d")}
    expose(:numero) {|model| model.store_order.numero}
    expose(:store_name) {|model| model.store.name}
  end
end
