module Api
  module Pos
    module Cashier
      class OrdersController < Api::BaseController
        def index
          unpaid_orders = current_store.store_orders.available.unpaid
          today_paid_orders = current_store.store_orders.available.paid_on(Time.now)
          @orders = unpaid_orders + today_paid_orders
        end

        def show
          order = StoreOrder.find(params[:id])
          render json: order
        end
      end
    end
  end
end
