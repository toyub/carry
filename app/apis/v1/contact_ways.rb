module V1
  class ContactWays < Grape::API

    resource :contact_ways do
      add_desc '回访方式列表'
      before do
        authenticate_user!
      end
      
      get do
        present StoreTracking::CONTACT_WAY.to_a, with: ::Entities::ContactWay
      end
    end

  end
end
