module Entities
  class Package < Grape::Entity
    expose :name
    expose :store_name
    expose :code
    expose :valid_date
    expose :retail_price
    expose :point
    expose :sold
    expose :abstract

    def retail_price
      object.package_setting.retail_price
    end
  end
end
