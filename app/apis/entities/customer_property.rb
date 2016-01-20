module Entities
  class CustomerProperty < Grape::Entity
    expose (:code) { |property, options| property.first }
    expose (:name) { |property, options| property.last }
  end
end
