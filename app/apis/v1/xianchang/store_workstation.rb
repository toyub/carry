module V1
  class Xianchang::StoreWorkstation < Grape::API

    resource 'xianchang', desc: "现场施工管理" do
      before do
        # authenticate_platform!
        # authenticate_user!
      end

      add_desc "切换工位"
      params do
        requires :platform, type: String, desc: '调用的平台(app或者erp)'
        requires :id, type: Integer, desc: '工位id'
        requires :workflow_id, type: Integer, desc: '流程id'
        requires :order_id, type: Integer, desc: '订单id'
        requires :previous_workstation_id, type: String, desc: '上一工位id'
      end
      put 'store_workstations/:id/exchange' do
        @workstation = current_store.workstations.find(params[:id])
        @store_order = current_store.store_orders.available.find(params[:order_id])
        @workflow = @store_order.workflows.find_by(id: params[:workflow_id])
        if @workflow.present?
          @previous_workstation = @workflow.store_workstation
          @workflow.change_workstation_to!(@workstation)
          present status: {success: true, notice: '切换工位成功'}
        else
          present status: {success: false, notice: '切换工位失败, 未找到工位'}
        end
      end

    end
  end
end
