module Erp
  class CustomerTrackingsController < BaseController
    before_action :set_customer

    def index
      q = @customer.trackings.ransack(params[:q])
      @trackings = q.result(distince: true)
      respond_with @trackings, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:customer_id])
      end
  end
end
