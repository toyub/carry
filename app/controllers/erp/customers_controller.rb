module Erp
  class StoreCustomersController < BaseController
    def index
      render text: 'fail', status: 401 and return unless AuthenticateTokenService.call(request.headers["HTTP_KEY"], request.headers["HTTP_SECRET"])
      @q = current_store.store_customers.ransack(params[:q])
      @customers = @q.result.select("DISTINCT ON (store_customers.id) store_customers.*")
      respond_with @customers, location: nil
    end

  end
end
