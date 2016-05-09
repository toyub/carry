module Report
  class StoreCustomerPaymentsController < BaseController
    def index
      @store_customer_payments = current_store.store_customer_payments
    end
  end
end
