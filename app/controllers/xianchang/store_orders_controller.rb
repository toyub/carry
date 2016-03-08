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

    def check_dispatch
      render json: {status: @store_order.store_vehicle.orders.task_processing.count == 0}
    end

    def check_mechanic
      render json: {status: @store_order.check_mechanic}
    end

    private
    def set_store_order
      @store_order = current_store.store_orders.find(params[:id])
    end
  end
end
