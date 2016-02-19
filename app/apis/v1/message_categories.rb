module V1
  class MessageCategories < Grape::API

    resource :message_categories do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc '短信类型列表'
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
      end
      get do
        present SmsSwitch.category, with: ::Entities::MessageCategory
      end
    end

  end
end
