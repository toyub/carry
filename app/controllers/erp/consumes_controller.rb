module Erp
  class ConsumesController < BaseController
    before_action :set_customer

    def index
      @orders = @customer.orders
      respond_with @orders, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:id])
      end
  end
end
