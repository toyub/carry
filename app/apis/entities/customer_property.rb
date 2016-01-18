module Entities
  class CustomerProperty < Grape::Entity
    expose :code do |property, options|
      property.first
    end
    expose :name do |property, options|
      property.last
    end
  end
end
