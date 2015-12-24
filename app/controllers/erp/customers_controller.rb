module Erp
  class CustomersController < BaseController
    def index
      @q = current_store_chain.store_customers.ransack(params[:q])
      @customers = @q.result(distinct: true)
      respond_with @customers, location: nil
    end
  end
end
