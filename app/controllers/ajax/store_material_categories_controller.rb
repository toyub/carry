module Ajax
  class StoreMaterialCategoriesController < Ajax::BaseController
    before_action :load_store

    def sub_categories
      @primary_category = @store.store_material_categories.find(params[:id])
      @sub_categories = @primary_category.sub_categories.order("created_at desc")

      respond_with @sub_categories
    end

    private
    def load_store
      @store = current_user.store
    end
  end
end
