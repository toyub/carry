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
        optional :material, type: Hash, default: {} do
          optional :material_id, type: String, desc: '商品的id'
          optional :count, type: String, desc: '商品的数量'
          optional :bargain_price, type: String, desc: '优惠价'
        end
        optional :service, type: Hash, default: {} do
          optional :service_id, type: String, desc: '服务的id'
          optional :count, type: String, desc: '服务的数量'
          optional :bargain_price, type: String, desc: '优惠价'
        end
        optional :package, type: Hash, default: {} do
          optional :package_id, type: Integer, desc: '套餐的id'
          optional :count, type: Integer, desc: '套餐的数量'
          optional :bargain_price, type: BigDecimal, desc: '优惠价'
        end
      end

      get do
        binding.pry

        material_ids = order_params[:material][:material_id].split(",")
        if params[:is_vip]
          StoreMaterial.where(id: material_ids).each do |material|
            
          end
        else
        end
        present info: 444
      end
    end

    helpers do
      def params_permit
        @order = ActionController::Parameters.new(params)
      end

      def basic_params
        params[:store_id] = current_store.id
        params[:store_chain_id] = current_store_chain.id
        params[:store_staff_id] = current_user.id
      end

      def order_params
        params_permit
        basic_params
        @order.permit(
          :is_vip,
          :platform,
          :customer_id,
          :store_id,
          :store_chain_id,
          :store_staff_id,
          material: [
            :material_id,
            :bargain_price,
            :count
          ],
          service: [
            :service_id,
            :bargain_price,
            :count
          ],
          package: [
            :package_id,
            :bargain_price,
            :count
          ]
        )
      end
    end

  end
end
