module Xianchang
  class StoreOrdersController < BaseController
    before_action :set_store_order

    def show
    end

    def terminate
      @state = params[:from]
      @store_order.terminate
      @store_order.reload
    end

    def update
      UpdateWorkflowService.call(order_params)
    end

    def check_dispatch
      render json: {status: @store_order.store_vehicle.orders.task_processing.available.count == 0}
    end

    def check_mechanic
      render json: {status: @store_order.check_mechanic}
    end

    private
    def set_store_order
      @store_order = current_store.store_orders.available.find(params[:id])
    end

    def order_params
      params.permit(workflow: [:store_workstation_id, :inspector, :used_time, mechanics: [:id, :name]])
    end
  end
end
