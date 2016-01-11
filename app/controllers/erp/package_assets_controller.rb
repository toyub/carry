module Erp
  class PackageAssetsController < BaseController
    before_action :set_customer

    def index
      @packages = @customer.packaged_assets
      respond_with @packages, location: nil
    end

    def show
      @package_asset = @customer.packaged_assets.find(params[:id])
      @items = @package_asset.items
      respond_with @package_asset, @items, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:customer_id])
      end
  end
end
