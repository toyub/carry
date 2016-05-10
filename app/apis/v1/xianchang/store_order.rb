module V1
  class Xianchang::StoreOrder < Grape::API

    resource 'xianchang', desc: "订单施工信息" do
      before do
        # authenticate_platform!
        # authenticate_user!
      end

      add_desc "获取订单施工信息"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :id, type: Integer, desc: '订单id'
      end
      get 'store_orders/:id' do
        @store_order = current_store.store_orders.available.find(params[:id])
        present @store_order, with: ::Entities::Xianchang::StoreOrder
      end

      add_desc "更新订单施工信息"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :id, type: Integer, desc: '订单id'
        # requires :workflow, type: Json, desc: '服务流程明细' do
        # end
      end
      put 'store_orders/:id' do
        @store_order = current_store.store_orders.available.find(params[:id])
        present hello: {"fd": "fda"}
      end

      add_desc "立即施工"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :id, type: Integer, desc: '订单id'
      end
      put 'store_orders/:id/execute' do
        @store_order = current_store.store_orders.available.find(params[:id])
        order_params = params.permit(workflow: [:id, :store_workstation_id, :inspector_id, :used_time, mechanics: [:id, :name, :group_member_id]])
        UpdateWorkflowService.call(order_params)
        workflow = @store_order.play!
        if workflow.present?
          if workflow.errors.present?
            flash[:error] = workflow.errors.messages.values.flatten.to_sentence
          end
        else
          flash[:error] = '当前订单没有可以施工的！'
        end
      end

      add_desc "修改订单施工流程状态"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :id, type: Integer, desc: '订单id'
        requires :operate, type: String, desc: '修改订单施工状态类型[terminate pause_in_queuing_area pause_in_workstation pause play]'
      end
      put 'store_orders/:id/change_workflow' do
        @store_order = current_store.store_orders.available.find(params[:id])
        if %w[terminate pause_in_queuing_area pause_in_workstation pause play].include? params[:operate]
          @store_order.send(params[:operate] + "!")
        end
      end

    end
  end
end
