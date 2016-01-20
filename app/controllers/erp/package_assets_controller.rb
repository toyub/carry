module Erp
  class PackageAssetsController < BaseController
    before_action :set_customer
    before_action :set_package_asset, only: [:show]

    def index
      @packages = @customer.packaged_assets
      respond_with @packages, location: nil
    end

    def show
      @items = @package_asset.items
      respond_with @package_asset, @items, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:customer_id])
      end

      def set_package_asset
        @package_asset = @customer.packaged_assets.find(params[:id])
      end
  end
end
