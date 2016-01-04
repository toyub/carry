module Receipt
  module Pos
    class OrdersController < BaseController
        def show
          @store_order = current_store.store_orders.find(params[:id])
        end
    end
  end
end
