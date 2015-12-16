module Api
  class StoreOrdersController < BaseController

    def index
      @orders = StoreOrder.page(params[:page]).per(10)
      render json: @orders
    end

    def mocked_orders
      orders = 18.times.map{Mocks::Order.mock}
      render json: orders
    end
    
  end
end
