module Api
  module Pos
    module Carts
      class ItemsController < Api::BaseController
        def show
          render json: {}
        end

        def destroy
          order = current_store.store_orders.find(params[:order_id])
          item = order.items.find(params[:id])
          item.destroy!
          respond_with item,location: nil
        end
      end
    end
  end
end
