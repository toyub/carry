module V1
  class MessageCategories < Grape::API

    resource :message_categories do
      add_desc '短信类型列表'
      before do
        authenticate_user!
      end
      
      get do
        present SmsNotifySwitchType::ID_TYPES.to_a, with: ::Entities::MessageCategory
      end
    end

  end
end
