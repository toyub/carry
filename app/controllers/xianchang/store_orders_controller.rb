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
      if @store_order.task_pending?
        @store_order.try_to_execute
      end
    end

    def execute
      UpdateWorkflowService.call(order_params)
    end

    def pause
      @store_order.pause!
    end

    def pause_in_queuing_area
      @store_order.pause_in_queuing_area!
    end

    def pause_in_workstation
      @store_order.pause_in_workstation!
    end

    def play
      @store_order.replay!
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
