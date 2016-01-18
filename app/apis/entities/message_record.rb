module Entities
  class MessageRecord < Grape::Entity
    expose :content
    expose :customer_name
    expose :phone_number
    expose :category do |record, options|
      record.first_category
    end
    expose :store_name do |record, options|
      record.store.name
    end
    expose :created_at do |record, options|
      record.created_at.strftime('%Y-%m-%d')
    end
  end
end
