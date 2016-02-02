module Api
  module Pos
    module Products
      class PackagesController < Api::BaseController
        def index
          @q = current_store.store_packages.ransack(params[:q])
          @packages = @q.result(distinct: true).order("id asc")
        end
      end
    end
  end
end
