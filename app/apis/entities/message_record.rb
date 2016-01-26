module Entities
  class MessageRecord < Grape::Entity
    expose :content
    expose :customer_name
    expose :phone_number
    expose :category
    expose(:store_name) { |record, options| record.store.try(:name) }
    expose(:created_at) { |record, options| record.created_at.strftime('%Y-%m-%d') }

    private
    def category
      first_category = SmsSwitchType.find(object.first_category.to_i)
      "#{first_category.name[:type]}-#{first_category.name[:sub_category].constantize.find(object.second_category.to_i).name}"
    end
  end
end
