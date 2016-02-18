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
        requires :customer_id, type: Integer, desc: '客户id'
        optional :material, type: Array do
          optional :count, type: Integer, desc: '商品的数量'
          optional :material_id, type: Integer, desc: '商品的id'
          optional :bargain_price, type: BigDecimal, desc: '优惠价'
        end
        optional :service, type: Array, default: {} do
          optional :count, type: Integer, desc: '服务的数量'
          optional :service_id, type: Integer, desc: '服务的id'
          optional :bargain_price, type: BigDecimal, desc: '优惠价'
        end
        optional :Package, type: Array, default: {} do
          optional :package_id, type: Integer, desc: '套餐的id'
          optional :count, type: Integer, desc: '套餐的数量'
          optional :bargain_price, type: BigDecimal, desc: '优惠价'
        end
      end

      get do
        binding.pry
        present info: 444
      end
    end

    helpers do
      def params_permit
        @order = ActionController::Parameters.new(params)
      end

      def material_params
        @order.permit()
      end
    end

  end
end
