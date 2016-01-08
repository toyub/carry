module Erp
  class DepositCardAssetsController < BaseController
    before_action :store_customer

    def show

    end

    private

      def store_customer
        @customer = current_store_chain.store_customers.find(params[:store_customer_id])
      end

  end
end
