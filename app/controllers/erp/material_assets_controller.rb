module Erp
  class MaterialAssetsController < BaseController
    before_action :set_customer

    def index
      @materials = @customer.taozhuang_assets
      respond_with @materials, location: nil
    end

    private

      def set_customer
        @customer = current_store_chain.store_customers.find(params[:customer_id])
      end
  end
end
