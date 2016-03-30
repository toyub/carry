module Api
  module Pos
    module Cashier
      class OrdersController < Api::BaseController
        def index
          @orders = current_store.store_orders.available
        end
      end
    end
  end
end
