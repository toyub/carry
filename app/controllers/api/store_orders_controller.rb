module Api
  class StoreOrdersController < BaseController

    def index
      orders = 18.times.map{Mocks::Order.mock}
      render json: orders
    end

    def show
      order = Mocks::Order.mock
      render json: order
    end
    
  end
end
