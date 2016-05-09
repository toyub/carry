module Report
  class StorePackageSoldLogsController < BaseController
    def index
      @sold_packages = current_store.store_order_items.packages
    end
  end
end
