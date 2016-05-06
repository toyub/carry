module V1
  class StoreOrderConstructionInfo < Grape::API

    resource :store_order_construction_info, desc: "订单施工信息" do
      before do
        authenticate_platform!
        authenticate_user!
      end

      add_desc "订单施工信息"
      route_param :order_id do
        before do
          @order = StoreOrder.find(params[:order_id])
        end
        params do
          requires :platform, type: String, desc: '调用的平台(app或者erp)'
        end
        get do
          present @order, with: ::Entities::StoreOrderConstructionInfo
        end
      end
    end
  end
end
