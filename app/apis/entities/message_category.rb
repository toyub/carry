module Entities
  class MessageCategory < Grape::Entity
    expose(:name) { |category, opton| category.name[:type] }
    expose :categories do |category, option|
      category.name[:sub_category].constantize.collection.map do |sub_category|
        {
          code: "#{category.id}-#{sub_category.id}",
          desc: "#{category.name[:type]}-#{sub_category.name}"
        }
      end
    end
  end
end
