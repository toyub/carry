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


      add_desc "消费记录"
      params do
        requires :customer_id, type: Integer, desc: '客户ID'
        optional :q, type: Hash, default: {} do
          optional :plate_id_eq, type: Integer, desc: "车牌ID"
          optional :created_at_gt, type: DateTime, desc: "开始时间"
          optional :created_at_lt, type: DateTime, desc: "结束时间"
        end
      end
      get ":customer_id/orders", requirements: { customer_id: /[0-9]*/ } do
        customer = StoreCustomer.find(params[:customer_id])
        q = customer.orders.ransack(params[:q])
        orders = q.result.order('id asc')
        present orders, with: ::Entities::Orders
      end

      add_desc "车牌的显示"
      params do
        requires :customer_id, type: Integer, desc: "客户id"
      end
      get ":customer_id/license_numbers", requirements: { customer_id: /[0-9]*/ } do
        customer = StoreCustomer.find(params[:customer_id])
        present customer.plates, with: ::Entities::LicenseNumbers
      end

      add_desc "套餐列表"
      params do
        requires :customer_id, type: Integer, desc: '客户ID'
      end
      get ":customer_id/package_assets", requirements: { customer_id: /[0-9]*/ } do
        customer = StoreCustomer.find(params[:customer_id])
        present customer.packaged_assets, with: ::Entities::PackageAssetsList
      end

      add_desc "套餐查看"
      params do
        requires :customer_id, type: Integer, desc: '客户ID'
        requires :id, type: Integer, desc: '套餐id'
      end
       get ":customer_id/package_assets/:id", requirements: { id: /[0-9]*/ } do
         customer = StoreCustomer.find(params[:customer_id])
         package_asset = customer.packaged_assets.find(params[:id])
         present package_asset, with: ::Entities::PackageAssetItem
       end

    end






  end
end
