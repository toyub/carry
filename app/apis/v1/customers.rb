module V1
  class Customers < Grape::API


    resource :customers, desc: "客户相关" do
      before do
        authenticate_user!
      end

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

      route_param :customer_id do
        before do
          @customer = current_store_chain.store_customers.find(params[:customer_id])
        end

        resource :customer_trackings do
          add_desc '客户回访记录列表'
          params do
            optional :q, type: Hash do
              optional :store_order_plate_id_eq, type: Integer
              optional :created_at_gt, type: String
              optional :created_at_lt, type: String
              optional :contact_way_id_eq, type: Integer
            end
          end
          get do
            q = @customer.trackings.ransack(params[:q])
            present q.result(distince: true), with: ::Entities::CustomerTracking
          end
        end

        resource :deposit_card_assets do
          add_desc '储值卡列表'
          get do
            present @customer.deposit_cards_assets, with: ::Entities::DepositCardAsset
          end
        end

        resource :deposit_logs do
          add_desc '储值卡消费记录'
          get do
            present @customer, with: ::Entities::DepositLogInfo
          end
        end

        resource :material_assets do
          add_desc '商品组合列表'
          get do
            present @customer.taozhuang_assets, with: ::Entities::MaterialAsset
          end

          add_desc '商品组合信息'
          get ':id' do
            material_asset = @customer.taozhuang_assets.find(params[:id])
            present material_asset, with: ::Entities::MaterialAssetInfo
          end
        end

        resource :license_numbers do
          add_desc '车牌列表'
          get do
            present @customer.plates, with: ::Entities::LicenseNumber
          end
        end

        resource :vehicles do
          add_desc '车辆列表'
          get do
            present @customer.store_vehicles, with: ::Entities::Vehicle
          end
        end

      end

      group do #group start
        before do
          @customer = current_store_chain.store_customers.find(params[:customer_id])
        end
        add_desc "资产-商品-项目消费明细"
        params do
          requires :material_asset_id, type: Integer, desc: "商品资产ID"
          requires :customer_id, type: Integer, desc: "客户ID"
          requires :id, type: Integer, desc: "项目ID"
        end
        get ":customer_id/material_assets/:material_asset_id/material_items/:id", requirements: { id: /[0-9]*/ } do
          material_asset = @customer.taozhuang_assets.find(params[:material_asset_id])
          present material_asset.items.find(params[:id]), with: ::Entities::MaterialItem
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
          q = @customer.orders.ransack(params[:q])
          orders = q.result.order('id asc')
          present orders, with: ::Entities::Order
        end

        add_desc "车牌的显示"
        params do
          requires :customer_id, type: Integer, desc: "客户id"
        end
        get ":customer_id/license_numbers", requirements: { customer_id: /[0-9]*/ } do
          present @customer.plates, with: ::Entities::LicenseNumber
        end

        add_desc "套餐列表"
        params do
          requires :customer_id, type: Integer, desc: '客户ID'
        end
        get ":customer_id/package_assets", requirements: { customer_id: /[0-9]*/ } do
          present @customer.packaged_assets, with: ::Entities::PackageAsset, type: :list
        end

        add_desc "套餐查看"
        params do
          requires :customer_id, type: Integer, desc: '客户ID'
          requires :id, type: Integer, desc: '套餐id'
        end
        get ":customer_id/package_assets/:id", requirements: { id: /[0-9]*/ } do
          package_asset = @customer.packaged_assets.find(params[:id])
          present package_asset, with: ::Entities::PackageAsset, type: :default
        end

        add_desc "套餐组合-查看-项目消费明细"
        params do
          requires :customer_id, type: Integer, desc: '客户ID'
          requires :package_asset_id, type: Integer, desc: "套餐资产id"
          requires :id, type: Integer, desc: '项目id'
        end
        get ":customer_id/packages_assets/:package_asset_id/package_items/:id", requirements: { id: /[0-9]*/ } do
          package_asset = @customer.packaged_assets.find(params[:package_asset_id])
          package_asset_item = package_asset.items.find(params[:id])
          present package_asset_item, with: ::Entities::PackageAsset, type: :full
        end
     end
     #group end
    end

  end
end
