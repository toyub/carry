module Entities
  class StorePackageItem < Grape::Entity
    expose(:store_package_item_id){|model| model.id}
    expose(:retail_price) {|model| model.package_itemable.retail_price}
    expose(:service_name) {|model| model.package_itemable.name}
    expose(:work_time) {|model| model.package_itemable.time}
    expose(:package_itemable_type) {|model|model.package_itemable_type}
    expose(:package_itemable_id) {|model|model.package_itemable_id}
  end

  class Package < Grape::Entity
    expose :name, :store_name, :code, :valid_date, :retail_price, :point, :sold, :abstract
    expose(:store_package_id) {|model|model.id}

    expose :package_services,using: StorePackageItem

    def package_services
      object.package_setting.services
    end
  end
end
