module Api
  module Crm
    class AssetsController < Api::BaseController
      def index
        @customer = current_store.store_customers.find(params[:customer_id])
      end
    end
  end
end
