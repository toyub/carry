module Api
  class StoreSubscribeOrdersController < BaseController

    def index
      @orders = StoreSubscribeOrder.page(params[:page]).per(15)
      render json: @orders
    end

  end
end
