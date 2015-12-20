module Api
  class StoreOrdersController < BaseController
    before_action :set_order, only: [:show]

    def index
      orders = 18.times.map{Mocks::Order.mock}
      render json: orders
    end

    def show
      #order = Mocks::Order.mock
      render json: @order
    end

    private

      def set_order
        @order = StoreOrder.find(params[:id])
      end
  end
end
