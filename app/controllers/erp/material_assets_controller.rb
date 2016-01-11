module Erp
  class MaterialAssetsController < BaseController
    before_action :set_customer
    before_action :set_material_asset, only: [:show]

    def index
      @materials = @customer.taozhuang_assets
      respond_with @materials, location: nil
    end

    def show
      @items = @material_asset.items
      respond_with @material_asset, @items, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:customer_id])
      end

      def set_material_asset
        @material_asset = @customer.taozhuang_assets.find(params[:id])
      end
  end
end
