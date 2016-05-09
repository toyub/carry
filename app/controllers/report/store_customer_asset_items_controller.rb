module Report
  class StoreCustomerAssetItemsController < BaseController
    def index
      @asset_item_logs = current_store.store_order_items.services.available.from_asset.order("id desc")
    end
  end
end
