module Entities
  class MessageRecord < Grape::Entity
    expose :content
    expose :receiver_name
    expose :phone_number
    expose :category
    expose(:store_name) { |record, options| record.party.try(:name) }
    expose(:created_at) { |record, options| record.created_at.strftime('%Y-%m-%d') }

    private
    def category
      if ["SmsNotifySwitchType", "SmsTrackingSwitchType", "SmsCaptchaSwitchType"].include? object.first_category
        "#{object.first_category.constantize.find(object.second_category.to_i).name}"
      end
    end
  end
end
