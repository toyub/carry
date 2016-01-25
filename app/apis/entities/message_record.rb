module Entities
  class MessageRecord < Grape::Entity
    expose :content
    expose :customer_name
    expose :phone_number
    expose(:category) { |record, options| record.first_category }
    expose(:store_name) { |record, options| record.store.try(:name) }
    expose(:created_at) { |record, options| record.created_at.strftime('%Y-%m-%d') }
  end
end
