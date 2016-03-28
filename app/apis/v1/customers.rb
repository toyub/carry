module V1
  class Customers < Grape::API


    resource :customers, desc: "客户相关" do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc "客户列表"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        optional :q, type: Hash, default: {} do
          optional :store_id_eq, type: Integer, desc: "所属门店ID"
        end
      end
      get do
        q = current_store_chain.store_customers.ransack(params[:q])
        present q.result.order('id asc'), with: ::Entities::Customer, type: :default
      end

      add_desc "客户详情"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
      end
      get ":id", requirements: { id: /[0-9]*/ } do
        present StoreCustomer.find(params[:id]), with: ::Entities::Customer, type: :full
      end

      route_param :customer_id do
        before do
          @customer = current_store_chain.store_customers.find(params[:customer_id])
        end

        resource :customer_trackings do
          add_desc '客户回访记录列表'
          params do
            requires :platform, type: String, desc: '调用的平台(app或者erp)'
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
          params do
            requires :platform, type: String, desc: '调用的平台(app或者erp)'
          end
          get do
            present @customer.deposit_cards_assets, with: ::Entities::DepositCardAsset
          end
        end

        resource :deposit_logs do
          add_desc '储值卡消费记录'
          params do
            requires :platform, type: String, desc: '调用的平台(app或者erp)'
          end
          get do
            present @customer, with: ::Entities::DepositLogInfo
          end
        end

        resource :material_assets do
          add_desc '商品组合列表'
          params do
            requires :platform, type: String, desc: '调用的平台(app或者erp)'
          end
          get do
            present @customer.taozhuang_assets, with: ::Entities::MaterialAsset
          end

          add_desc '商品组合信息'
          params do
            requires :platform, type: String, desc: '调用的平台(app或者erp)'
          end
          get ':id' do
            material_asset = @customer.taozhuang_assets.find(params[:id])
            present material_asset, with: ::Entities::MaterialAssetInfo
          end

          route_param :material_asset_id do
            add_desc "资产-商品-项目消费明细"
            params do
              requires :platform, type: String, desc: '调用的平台(app或者erp)'
              requires :id, type: Integer, desc: "项目ID"
            end
            get "material_items/:id", requirements: { id: /[0-9]*/ } do
              material_asset = @customer.taozhuang_assets.find(params[:material_asset_id])
              present material_asset.items.find(params[:id]), with: ::Entities::MaterialItem
            end
          end
        end

        resource :license_numbers do
          add_desc '车牌列表'
          params do
            requires :platform, type: String, desc: '调用的平台(app或者erp)'
          end
          get do
            present @customer.plates, with: ::Entities::LicenseNumber
          end
        end

        resource :vehicles do
          add_desc '车辆列表'
          params do
            requires :platform, type: String, desc: '调用的平台(app或者erp)'
          end
          get do
            present @customer.store_vehicles, with: ::Entities::Vehicle
          end
        end

        resource :assets do
          add_desc "资产(服务)"
          params do
            requires :platform, type: String, desc: '调用的平台'
          end
          get do
            assets = @customer.assets.serviceable.select(&->(asset){asset.available_items.present?})
            present assets, with: ::Entities::AssetServiceable
          end
        end

        add_desc "消费记录"
        params do
          requires :platform, type: String, desc: '调用的平台(app或者erp)'
          optional :q, type: Hash, default: {} do
            optional :plate_id_eq, type: Integer, desc: "车牌ID"
            optional :created_at_gt, type: DateTime, desc: "开始时间"
            optional :created_at_lt, type: DateTime, desc: "结束时间"
          end
        end
        get "orders", requirements: { customer_id: /[0-9]*/ } do
          q = @customer.orders.available.ransack(params[:q])
          orders = q.result.order('id asc')
          present orders, with: ::Entities::Order
        end

        resource :package_assets, desc: "套餐相关" do
          add_desc "套餐列表"
          params do
            requires :platform, type: String, desc: '调用的平台(app或者erp)'
          end
          get "/", requirements: { customer_id: /[0-9]*/ } do
            present @customer.packaged_assets, with: ::Entities::PackageAsset, type: :list
          end

          add_desc "套餐查看"
          params do
            requires :platform, type: String, desc: '调用的平台(app或者erp)'
            requires :id, type: Integer, desc: '套餐id'
          end
          get ":id", requirements: { id: /[0-9]*/ } do
            package_asset = @customer.packaged_assets.find(params[:id])
            present package_asset, with: ::Entities::PackageAsset, type: :default
          end

          route_param :package_asset_id do
            add_desc "套餐组合-查看-项目消费明细"
            params do
              requires :platform, type: String, desc: '调用的平台(app或者erp)'
              requires :id, type: Integer, desc: '项目id'
            end
            get "package_items/:id", requirements: { id: /[0-9]*/ } do
              package_asset = @customer.packaged_assets.find(params[:package_asset_id])
              package_asset_item = package_asset.items.find(params[:id])
              present package_asset_item, with: ::Entities::PackageAsset, type: :full
            end
          end
        end

      end

    end

  end
end
