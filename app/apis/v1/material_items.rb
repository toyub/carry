module V1
  class MaterialItems < Grape::API

    # resource :material_items, desc: '商品的相关' do
    #   add_desc "商品的相关条目"
    #   params do
    #     requires :material_asset_id, type: Integer, desc: "商品资产ID"
    #     requires :customer_id, type: Integer, desc: "客户ID"
    #     requires :id, type: Integer, desc: "客户ID"
    #   end
    #
    #   get "/customers/:customer_id/material_assets/:material_asset_id/material_items/:id", requirements: { id: /[0-9]*/ } do
    #     customer = current_store_chain.store_customers.find(params[:customer_id])
    #
    #     present StoreCustomer.find(params[:id]), with: ::Entities::Customer
    #   end
    #
    # end

  end
end
