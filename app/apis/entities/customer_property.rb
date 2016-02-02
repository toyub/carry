module Entities
  class CustomerProperty < Grape::Entity
    expose(:code) { |property, options| property }
    expose(:name) { |property, options| I18n.t "enums.store_customer_entity.property.#{property}" }
  end
end
