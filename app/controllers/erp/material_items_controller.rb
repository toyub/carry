module Erp
  class MaterialItemsController < BaseController
    before_action :set_customer, :set_material_asset, :set_material_asset_item

    def show
      @logs = @material_asset_item.logs
      respond_with @logs, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:customer_id])
      end

      def set_material_asset
        @material_asset = @customer.taozhuang_assets.find(params[:material_asset_id])
      end

      def set_material_asset_item
        @material_asset_item = @material_asset.items.find(params[:id])
      end
  end
end
