module V1
  class MessageCategories < Grape::API

    resource :message_categories do
      before do
        authenticate_user!
      end

      add_desc '短信类型列表'
      get do
        present SmsSwitchType.collection, with: ::Entities::MessageCategory
      end
    end

  end
end
