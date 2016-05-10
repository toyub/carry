module Report
  class StoreOrdersController < BaseController
    def index
      @store_orders = current_store.store_orders.available.unpending
    end
  end
end
