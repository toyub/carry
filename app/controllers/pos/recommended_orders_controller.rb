module Pos
  class RecommendedOrdersController < Pos::BaseController
    def index
      @orders = current_store.recommended_orders
    end

    def new
      @order = current_store.recommended_orders.new
    end

    def edit
      @order = current_store.recommended_orders.find(params[:id])
    end
  end
end
