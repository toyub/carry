module V1
  class StoreOrders < Grape::API
    before do
      authenticate_platform!
      authenticate_user!
    end

    resource :store_orders, desc: "订单相关" do
      add_desc "订单提交(确认订单)"
      params do
        requires :is_vip, type: Boolean, desc: '是否是会员客户'
        requires :platform, type: String, desc: '验证平台！'
        requires :store_customer_id, type: Integer, desc: '客户id'
        requires :vehicle_id, type: Integer, desc: '车辆的id'
        optional :plate_id, type: Integer, desc: '车牌的id'
        optional :materials, type: Array do
          optional :material_id, type: Integer, desc: '商品的id'
          optional :quantity, type: Integer, desc: '商品的数量'
          optional :retail_price, type: BigDecimal, desc: '销售单价'
          optional :vip_price, type: BigDecimal, desc: '会员价'
          optional :discount, type: BigDecimal, desc: '优惠价'
          optional :discount_reason, type: String, desc: '优惠理由'
          optional :price, type: BigDecimal, desc: '单价'
        end
        optional :services, type: Array do
          optional :service_id, type: Integer, desc: '服务的id'
          optional :quantity, type: Integer, desc: '服务的数量'
          optional :price, type: BigDecimal, desc: '单价'
          optional :from_asset, type: Boolean, desc: '是否卡扣'
          optional :store_customer_asset_item_id, type: Integer, desc: '卡扣的id'
        end
        optional :packages, type: Array do
          optional :package_id, type: Integer, desc: '套餐的id'
          optional :quantity, type: Integer, desc: '套餐的数量'
          optional :price, type: BigDecimal, desc: '单价'
        end
        optional :material_services, type: Array do
          optional :store_material_saleinfo_id, type: Integer, desc: '商品信息的id'
          optional :store_material_saleinfo_service_id, type: Integer, desc: '商品服务的id'
        end
      end

      add_desc '下单'
      post do
        status = GenerateOrderService.call(order_params, basic_params)
        present status: status.success, info: status.notice
      end

      route_param :order_id do
        before do
          @order = StoreOrder.find(params[:order_id])
        end
        add_desc '订单更新(订单编辑)'
        params do
          requires :order_id, type: Integer, desc: '订单的id'
          requires :is_vip, type: Boolean, desc: '是否是会员客户'
          requires :platform, type: String, desc: '验证平台！'
          requires :store_customer_id, type: Integer, desc: '客户id'
          optional :plate_id, type: Integer, desc: '车牌的id'
          optional :materials, type: Array do
            optional :material_id, type: Integer, desc: '商品的id'
            optional :quantity, type: Integer, desc: '商品的数量'
            optional :retail_price, type: BigDecimal, desc: '销售单价'
            optional :vip_price, type: BigDecimal, desc: '会员价'
            optional :discount, type: BigDecimal, desc: '优惠价'
            optional :discount_reason, type: String, desc: '优惠理由'
            optional :price, type: BigDecimal, desc: '单价'
          end
          optional :services, type: Array do
            optional :service_id, type: Integer, desc: '服务的id'
            optional :quantity, type: Integer, desc: '服务的数量'
            optional :price, type: BigDecimal, desc: '单价'
            optional :from_asset, type: Boolean, desc: '是否卡扣'
            optional :store_customer_asset_item_id, type: Integer, desc: '卡扣的id'
          end
          optional :packages, type: Array do
            optional :package_id, type: Integer, desc: '套餐的id'
            optional :quantity, type: Integer, desc: '套餐的数量'
            optional :price, type: BigDecimal, desc: '单价'
          end
          optional :material_services, type: Array do
            optional :store_material_saleinfo_id, type: Integer, desc: '商品信息的id'
            optional :store_material_saleinfo_service_id, type: Integer, desc: '商品服务的id'
          end
        end
        put  do
          order = StoreOrder.find(params[:order_id])
          status = GenerateOrderService.call(order_params, basic_params, order: order)
          present status: status.success, info: status.notice
        end

        add_desc '取消订单'
        params do
          requires :order_id, type: Integer, desc: '订单的id'
          requires :platform, type: String, desc: '验证平台！'
        end
        delete  do
          @order.delete
          present info: '取消订单成功'
        end

        add_desc '订单详情'
        params do
          requires :platform, type: String, desc: '验证平台！'
          requires :order_id, type: Integer, desc: '订单的id'
        end
        get do
          present @order.items, with: ::Entities::StoreOrder, type: :full
        end

      end

      add_desc '订单列表'
      params do
        requires :platform, type: String, desc: '验证平台！'
        optional :q, type: Hash, default: {} do
          optional :plate_license_number_cont, type: String
          optional :store_customer_phone_number_cont, type: String
          optional :state_eq, type: Integer
        end
      end
      get do
        orders = current_store.store_orders.ransack(params[:q]).result
        present orders, with: ::Entities::StoreOrder, type: :default
      end
    end

    helpers do
      def params_permit
        @order = ActionController::Parameters.new(params)
      end

      def basic_params
        params_permit
        params[:store_id] = current_store.id
        params[:store_chain_id] = current_store_chain.id
        params[:store_staff_id] = current_user.id
        @order.permit(:store_id,
                      :store_chain_id,
                      :store_staff_id)
      end

      def order_params
        params_permit
        basic_params
        @order.permit(
          :is_vip,
          :platform,
          :vehicle_id,
          :plate_id,
          :store_customer_id,
          :store_id,
          :store_chain_id,
          :store_staff_id,
          materials: [
            :material_id,
            :retail_price,
            :quantity,
            :vip_price,
            :price,
            :discount,
            :discount_reason
          ],
          services: [
            :service_id,
            :quantity,
            :price,
            :from_asset,
            :store_customer_asset_item_id
          ],
          packages: [
            :package_id,
            :quantity,
            :price
          ],
          material_services: [
            :store_material_saleinfo_id,
            :store_material_saleinfo_service_id
          ]
        )
      end
    end

  end
end
