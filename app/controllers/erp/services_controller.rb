module Erp
  class ServicesController < BaseController
    def index
      q = current_store_chain.store_services.ransack(params.with_indifferent_access[:q])
      @services = q.result(distinct: true)
      respond_with @services, location: nil
    end
  end
end
