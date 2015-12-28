module Xianchang
  class StoreOrdersController < BaseController
    def show
      @order = current_store.store_orders.find(params[:id])
    end
  end
end
