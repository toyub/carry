module Erp
  class CustomersController < BaseController
    def index
      @q = current_store_chain.store_customers.ransack(params[:q])
      @customers = @q.result(distinct: true)
      respond_with @customers, location: nil
    end

    def show
      @customer = current_store_chain.store_customers.find(params[:id])
      respond_with @customer, location: nil
    end

  end
end
