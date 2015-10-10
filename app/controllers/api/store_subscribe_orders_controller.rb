module Api
  class StoreSubscribeOrdersController < BaseController

    def index
      @orders = StoreSubscribeOrder.joins(:store_customer).where("store_customers.phone_number like ?", "%#{params[:phone]}")
      @orders = @orders.where(subscribe_date: params[:subscribe_date]) if params[:subscribe_date].present?
      @orders = @orders.page(params[:page]).per(15)
      render json: @orders
    end

    def destroy
    end

  end
end
