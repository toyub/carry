module Erp
  class PackagesController < BaseController
    def index
      q = current_store_chain.store_packages.ransack(params[:q])
      @packages = q.result.order('id asc')
      respond_with @packages, location: nil
    end
  end
end
