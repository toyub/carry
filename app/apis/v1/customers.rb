module V1
  class Customers < Grape::API

    resource :customers, desc: "客户相关" do
      add_desc "客户列表"
      params do
        optional :q, type: Hash, default: {} do
          optional :store_id_eq, type: Integer, desc: "所属门店ID"
        end
      end
      get do
        q = StoreCustomer.ransack(params[:q])
        present q.result.order('id asc'), with: ::Entities::Customer
      end

      add_desc "客户详情"
      get ":id", requirements: { id: /[0-9]*/ } do
        present StoreCustomer.find(params[:id]), with: ::Entities::Customer
      end

      add_desc "资产-商品-项目消费明细"
      params do
        requires :material_asset_id, type: Integer, desc: "商品资产ID"
        requires :customer_id, type: Integer, desc: "客户ID"
        requires :id, type: Integer, desc: "项目ID"
      end
      get ":customer_id/material_assets/:material_asset_id/material_items/:id", requirements: { id: /[0-9]*/ } do
        customer = StoreCustomer.find(params[:customer_id])
        material_asset = customer.taozhuang_assets.find(params[:material_asset_id])
        present material_asset.items.find(params[:id]).logs, with: ::Entities::MaterialItems
      end

    end






  end
end
