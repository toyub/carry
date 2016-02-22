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
        optional :materials, type: Array do
          optional :material_id, type: Integer, desc: '商品的id'
          optional :count, type: Integer, desc: '商品的数量'
          optional :price, type: BigDecimal, desc: '单价'
          optional :vip_price, type: BigDecimal, desc: '会员价'
          optional :discount, type: BigDecimal, desc: '优惠价'
          optional :discount_reason, type: String, desc: '优惠理由'
          optional :from_asset, type: Boolean, desc: '是否卡扣'
        end
        optional :services, type: Array do
          optional :service_id, type: Integer, desc: '服务的id'
          optional :count, type: Integer, desc: '服务的数量'
          optional :price, type: BigDecimal, desc: '单价'
          optional :vip_price, type: BigDecimal, desc: '会员价'
          optional :discount, type: BigDecimal, desc: '优惠价'
          optional :discount_reason, type: String, desc: '优惠理由'
          optional :from_asset, type: Boolean, desc: '是否卡扣'
        end
        optional :packages, type: Array do
          optional :package_id, type: Integer, desc: '套餐的id'
          optional :count, type: Integer, desc: '套餐的数量'
          optional :price, type: BigDecimal, desc: '单价'
        end
      end

      add_desc '下单'
      post do
        status = GenerateOrderService.call(order_params, basic_params)
        present status: status.success, info: status.notice
      end

      add_desc '订单更新(订单编辑)'
      params do
        requires :order_id, type: Integer, desc: '订单的id'
        requires :is_vip, type: Boolean, desc: '是否是会员客户'
        requires :platform, type: String, desc: '验证平台！'
        requires :store_customer_id, type: Integer, desc: '客户id'
        optional :materials, type: Array do
          optional :material_id, type: Integer, desc: '商品的id'
          optional :count, type: Integer, desc: '商品的数量'
          optional :price, type: BigDecimal, desc: '单价'
          optional :vip_price, type: BigDecimal, desc: '会员价'
          optional :discount, type: BigDecimal, desc: '优惠价'
          optional :discount_reason, type: String, desc: '优惠理由'
          optional :from_asset, type: Boolean, desc: '是否卡扣'
        end
        optional :services, type: Array do
          optional :service_id, type: Integer, desc: '服务的id'
          optional :count, type: Integer, desc: '服务的数量'
          optional :price, type: BigDecimal, desc: '单价'
          optional :vip_price, type: BigDecimal, desc: '会员价'
          optional :discount, type: BigDecimal, desc: '优惠价'
          optional :discount_reason, type: String, desc: '优惠理由'
          optional :from_asset, type: Boolean, desc: '是否卡扣'
        end
        optional :packages, type: Array do
          optional :package_id, type: Integer, desc: '套餐的id'
          optional :count, type: Integer, desc: '套餐的数量'
          optional :price, type: BigDecimal, desc: '单价'
        end
      end
      put ":order_id", requirements: { id: /[0-9]*/ } do
        order = StoreOrder.find(params[:order_id])
        status = GenerateOrderService.call(order_params, basic_params, order: order)
        present status: status.success, info: status.notice
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
          :store_customer_id,
          :store_id,
          :store_chain_id,
          :store_staff_id,
          materials: [
            :material_id,
            :bargain_price,
            :count,
            :vip_price,
            :price,
            :discount,
            :discount_reason,
            :from_asset
          ],
          services: [
            :service_id,
            :bargain_price,
            :count,
            :vip_price,
            :price,
            :discount,
            :discount_reason,
            :from_asset
          ],
          packages: [
            :package_id,
            :bargain_price,
            :count,
            :vip_price,
            :price,
            :discount,
            :discount_reason,
            :from_asset
          ]
        )
      end
    end

  end
end
