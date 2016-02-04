module V1
  class CustomerProperties < Grape::API

    resource :customer_properties do
      before do
        authenticate_user!
      end

      add_desc '客户属性列表'

      get do
        present StoreCustomerEntity.properties.keys, with: ::Entities::CustomerProperty
      end
    end

  end
end
