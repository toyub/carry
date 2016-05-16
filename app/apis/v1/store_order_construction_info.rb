module V1
  class StoreOrderWorkflow < Grape::API

    resource :store_order_workflow, desc: "订单施工信息2" do
      before do
        authenticate_platform!
        authenticate_user!
      end

      route_param :order_id do
        before do
          @order = StoreOrder.find(params[:order_id])
        end

        add_desc "订单施工信息2"
        params do
          requires :platform, type: String, desc: '调用的平台(app或者erp)'
        end
        get do
          present @order, with: ::Entities::StoreOrderWorkflow
        end

        add_desc "开始施工"
        params do
          requires :platform, type: String, desc: '调用的平台(app或者erp)'
        end
        put 'start' do
          present @order, with: ::Entities::StoreOrderWorkflow
        end

      end
    end
  end
end
