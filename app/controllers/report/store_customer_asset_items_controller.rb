module Report
  class StoreCustomerAssetItemsController < BaseController
    def index
      @asset_item_logs = current_store.store_order_items.services.available.from_asset.joins(:store_order).paid.order("id desc")
    end
  end
end
