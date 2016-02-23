module Entities
  class MessageCategory < Grape::Entity
    expose(:name) { |category, opton| category[:cn_name] }
    expose :categories do |category, option|
      category[:sub_category].map do |sub|
        {
          code: "#{category[:name]}-#{sub.id}",
          desc: "#{category[:cn_name]}-#{sub.name}"
        }
      end
    end
  end
end
