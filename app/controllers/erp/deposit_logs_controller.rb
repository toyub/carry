module Erp
  class DepositLogsController < BaseController
    before_action :set_customer

    def index
      @deposit_logs = @customer.deposit_logs
      respond_with @deposit_logs, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:customer_id])
      end

  end
end
