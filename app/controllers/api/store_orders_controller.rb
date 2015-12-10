module Api
  class StoreOrdersController < BaseController

    def index
      @orders = StoreOrder.page(params[:page]).per(10)
      render json: @orders
    end
    
  end
end
