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

        resources :material_assets do
          add_desc '商品组合列表'
          get do
            present @customer.taozhuang_assets, with: ::Entities::MaterialAsset
          end

          add_desc '商品组合有关信息'
          get ':id' do
            material_asset = @customer.taozhuang_assets.find(params[:id])
            present material_asset, with: ::Entities::MaterialAssetInfo
          end
        end

        resources :license_numbers do
          add_desc '车牌列表'
          get do
            q = @customer.plates.ransack(params[:q])
            present q.result(distinct: true), with: ::Entities::LicenseNumber
          end
        end

      end

    end

  end
end
