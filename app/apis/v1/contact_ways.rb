module V1
  class ContactWays < Grape::API

    resource :contact_ways do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc '回访方式列表'
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
      end
      get do
        present StoreTracking::CONTACT_WAY.to_a, with: ::Entities::ContactWay
      end
    end

  end
end
