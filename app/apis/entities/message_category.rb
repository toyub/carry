module Entities
  class MessageCategory < Grape::Entity
    expose :code do |category, options|
      category.first
    end

    expose :name do |category, options|
      category.last
    end

  end
end
