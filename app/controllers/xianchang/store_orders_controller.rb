module Xianchang
  class StoreOrdersController < BaseController
    before_action :set_store_order

    def show
    end

    def terminate
      @state = params[:from]
      @store_order.force_finish!
      @store_order.reload
    end

    def update
      UpdateWorkflowService.call(order_params)
      @store_order.execution_job
    end

    def execute
      UpdateWorkflowService.call(order_params)
      music = @store_order.play!
      if music.present?
        if music.errors.present?
          flash[:error] = music.errors.messages.values.flatten.to_sentence
        end
      else
        flash[:error] = '当前订单没有可以施工的！'
      end
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
