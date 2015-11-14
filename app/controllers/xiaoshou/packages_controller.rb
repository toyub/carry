module Xiaoshou
  class PackagesController < Xiaoshou::BaseController
    respond_to :html

    def index
      @q = current_store.store_packages.ransack(params[:q])
      @packages = @q.result(distinct: true)
      respond_with @packages
    end

  end
end
