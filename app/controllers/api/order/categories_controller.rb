module Api
  module Order
    class CategoriesController < BaseController
      before_action :get_service_category, only: [:service_category]
      before_action :get_sale_category, only: [:sale_category]
      def sale_category
        respond_with @sale_category, location: nil
      end

      def service_category
        respond_with @service_category, location: nil
      end

      private
      def get_service_category
        @service_category = ServiceCategory.all
      end

      def get_sale_category
        @sale_category = SaleCategory.all
      end
    end
  end
end
