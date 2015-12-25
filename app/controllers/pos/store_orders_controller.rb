module Pos
  class StoreOrdersController < Pos::BaseController
    def index
      @orders = current_store.store_orders
    end

    def new
      @order = current_store.store_orders.new
    end

    def edit
      @order = current_store.store_orders.find(params[:id])
    end
  end
end
