module Entities
  class MessageCategory < Grape::Entity
    expose (:code) { |category, options| category.first }
    expose (:name) { |category, options| category.last }
  end
end
