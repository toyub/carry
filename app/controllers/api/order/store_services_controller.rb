module Api
  module Order
    class StoreServicesController < BaseController
      def index
        @services = @store.store_services.by_category(params[:service_category_id])
        respond_with @services, location: nil
      end

      def service_name
        # params[:q] = { service_category_name_or_name_cont: params[:name_cont] }
        @q = @store.store_services.ransack(params[:q])
        @services = @q.result
        respond_with @services, location: nil
      end

    end
  end
end
