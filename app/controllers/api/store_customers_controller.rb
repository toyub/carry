module Api
  class StoreCustomersController < BaseController
    def index
      @q = current_store.store_customers.ransack(params[:q])
      @customers = @q.result(distinct: true)
    end

  end
end
