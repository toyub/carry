module Api
  module Pos
    module Products
      class ServicesController < Api::BaseController
        def index
          @q = current_store.store_services.ransack(params[:q])
          @services = @q.result.order("id asc")
        end
      end
    end
  end
end
