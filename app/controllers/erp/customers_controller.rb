module Erp
  class CustomersController < BaseController
    def index
      @q = current_store.store_customers.ransack(params[:q])
      @customers = @q.result.select("DISTINCT ON (store_customers.id) store_customers.*")
      respond_with @customers, location: nil
    end

  end
end
