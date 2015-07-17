module Ajax
  class StoreMaterialCategoriesController < Ajax::BaseController

    def sub_categories
      @primary_category = current_store.store_material_categories.find(params[:id])
      @sub_categories = @primary_category.sub_categories.order("created_at desc")

      respond_with @sub_categories
    end

  end
end
