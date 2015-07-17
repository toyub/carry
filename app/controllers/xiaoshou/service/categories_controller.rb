module Xiaoshou
  module Service
    class CategoriesController < Xiaoshou::BaseController
      respond_to :json

      def create
        @category = current_store.service_categories.create(category_params)
        respond_with @category, location: nil
      end

      private

      def category_params
        params.require(:store_service_category).permit(:name)
      end
    end
  end
end
