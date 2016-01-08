module Erp
  class AssetsController < BaseController
    before_action :set_customer

    def index
      @deposit_cards = @customer.deposit_cards_assets
      @packages = @customer.packaged_assets
      @materials = @customer.taozhuang_assets
      respond_with @deposit_cards, @packages, @materials, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:customer_id])
      end
  end
end
