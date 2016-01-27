module Erp
  class PackageItemsController < BaseController
    before_action :set_customer, :set_package_asset, :set_package_asset_item

    def show
      @logs = @package_asset_item.logs
      respond_with @logs, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:customer_id])
      end

      def set_package_asset
        @package_asset = @customer.packaged_assets.find(params[:package_asset_id])
      end

      def set_package_asset_item
        @package_asset_item = @package_asset.items.find(params[:id])
      end
  end
end
