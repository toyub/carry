module Api
  module Products
    class ServicesController < Api::BaseController
      def index
        @q = current_store.store_services.ransack(params[:q])
        @services = @q.result(distinct: true).order("id asc")
      end
    end
  end
end
