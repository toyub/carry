module Api
  module Order
    class StoreServiceController < BaseController
      before_action :get_service, only: [:service_categories]
      def service_categories
        
      end

      private
      def get_service
        @service_category = ServiceCategory.where(id: params[:service_category_id]).last
      end
    end
  end
end
