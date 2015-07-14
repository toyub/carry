module Xiaoshou
  module Service
    class CategoriesController < Xiaoshou::BaseController
      respond_to :json

      before_action :load_store

      def create
        @category = @store.service_categories.create(category_params)
        respond_with @category, location: nil
      end

      private
      def load_store
        @store = current_user.store
      end

      def category_params
        params.require(:store_service_category).permit(:name)
      end
    end
  end
end
