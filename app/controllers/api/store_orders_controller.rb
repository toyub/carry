module Api
  class StoreOrdersController < BaseController
    before_action :set_order, only: [:show]

    def index
      orders = StoreOrder.all
      render json: orders
    end

    def show
      render json: @order
    end

    private

      def set_order
        @order = StoreOrder.find(params[:id])
      end
  end
end
