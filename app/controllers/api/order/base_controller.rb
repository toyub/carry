module Api
  module Order
    class BaseController < ApplicationController
      before_action :get_store, :get_store_staff
      skip_before_action :verify_authenticity_token
      respond_to :json

      private
      def get_store
        @store = Store.find(2488)
      end

      def get_store_staff
        @staffer = StoreStaff.find(2491)
      end

      def get_customer
        @customer = StoreCustomer.find(2)
      end

      private
      def basic_data
        params[:store_id] = @store.id
        params[:store_chain_id] = @store.store_chain_id
        params[:store_staff_id] = @staff.id
        patams[:store_customer_id] = @customer.id
      end
    end
  end
end
