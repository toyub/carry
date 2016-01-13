module Erp
  class DepositCardAssetsController < BaseController
    before_action :set_customer

    def index
      @deposit_cards = @customer.deposit_cards_assets
      respond_with @deposit_cards, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:customer_id])
      end

  end
end
