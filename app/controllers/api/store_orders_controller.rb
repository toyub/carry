module Api
  class StoreOrdersController < BaseController
    before_action :set_order, only: [:show]

    def index
      orders = 18.times.map{Mocks::Order.mock}
      render json: orders
    end

    def show
<<<<<<< e11068ae9bca0f5248477154fce4b807ce0ca861
      #order = Mocks::Order.mock
      render json: @order
=======
      order = Mocks::Order.find_by_id(params[:id])
      render json: order
>>>>>>> 5c9e3319cb56026b609d1d6019babd1d4d88cc73
    end

    private

      def set_order
        @order = StoreOrder.find(params[:id])
      end
  end
end
