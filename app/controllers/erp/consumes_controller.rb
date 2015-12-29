module Erp
  class ConsumesController < BaseController
    before_action :set_customer

    def index
      q = @customer.orders.ransack(params[:q])
      @orders = q.result(distinct: true).order('id asc')
      respond_with @orders, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:id])
      end
  end
end
