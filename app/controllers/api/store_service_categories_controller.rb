module Api
  class StoreServiceCategoriesController < BaseController
    def create
      @category = current_store.service_categories.create(append_store_attrs category_params)
      respond_with @category, location: nil
    end

    private

      def category_params
        params.require(:store_service_category).permit(:name)
      end
  end
end
