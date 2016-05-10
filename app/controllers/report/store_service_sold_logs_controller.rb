module Report
  class StoreServiceSoldLogsController < BaseController
    def index
      @services_sold = current_store.store_order_items.pure_services
    end
  end
end
