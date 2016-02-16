module V1
  class CustomerProperties < Grape::API

    resource :customer_properties do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc '客户属性列表'
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
      end
      get do
        present StoreCustomerEntity.properties.keys, with: ::Entities::CustomerProperty
      end
    end

  end
end
