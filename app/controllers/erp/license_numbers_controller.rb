module Erp
  class LicenseNumbersController < BaseController
    before_action :set_customer

    def index
      q = @customer.plates.ransack(params[:q])
      @plates = q.result(distinct: true)
      respond_with @plates, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:id])
      end
  end
end
