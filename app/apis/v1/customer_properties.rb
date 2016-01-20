module V1
  class CustomerProperties < Grape::API

    resource :customer_properties do
      add_desc '客户属性列表'
      before do
        authenticate_user!
      end
      
      get do
        present StoreCustomerEntity::PROPERTIES.to_a, with: ::Entities::CustomerProperty
      end
    end

  end
end
