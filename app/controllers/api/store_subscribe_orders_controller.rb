module Api
  class StoreSubscribeOrdersController < BaseController

    protect_from_forgery except: :destroy

    def index
      @orders = StoreSubscribeOrder.joins(:store_customer).where("store_customers.phone_number like ?", "%#{params[:phone]}")
      @orders = @orders.where(subscribe_date: params[:subscribe_date]) if params[:subscribe_date].present?
      @orders = @orders.where(state: params[:state]) if params[:state].present?
      @orders = @orders.page(params[:page]).per(15)
      render json: @orders
    end

    def destroy
      @order = StoreSubscribeOrder.find(params[:id])
      @order.destroy
      render json: {success: true}
    end

  end
end
