module Api
  module Order
    class StoreServicesController < BaseController
      before_action :get_service, only: [:service_categories]
      def service_name
        params[:q] = { name_or_service_category_name_cont: params[:name_cont] }
        @q = @store.store_services.ransack(params[:q])
        @services = @q.result
        respond_with @services, location: nil
      end

      private
      def get_service
        @service_category = ServiceCategory.where(id: params[:service_category_id]).last
      end
    end
  end
end
