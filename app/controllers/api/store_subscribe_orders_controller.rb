module Api
  class StoreSubscribeOrdersController < BaseController

    before_action :set_order, only: [:destroy, :update]
    protect_from_forgery except: :destroy

    def index
      @orders = if params[:number_val].present?
                  StoreSubscribeOrder.joins(:store_customer).
                    where("store_customers.phone_number like ?", "%#{params[:number_val]}%")
                else
                  StoreSubscribeOrder.all
                end
      @orders = @orders.where(subscribe_date: params[:subscribe_date]) if params[:subscribe_date].present?
      @orders = @orders.where(state: params[:state]) if params[:state].present?

      @orders = @orders.page(params[:page]).per(15)
      render json: @orders
    end

    def destroy
      @order.destroy
      render json: {success: true}
    end

    def update
      if @order.update(order_params)
        render json: {success: true}
      else
        render json: {success: false}
      end
    end

    private

      def order_params
        params.require(:store_subscribe_order).permit(:state)
      end

      def set_order
        @order = StoreSubscribeOrder.find(params[:id])
      end
  end
end
