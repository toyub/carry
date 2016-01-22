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
  end
end
