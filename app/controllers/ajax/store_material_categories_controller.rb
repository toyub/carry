module Ajax
  class StoreMaterialCategoriesController < Ajax::BaseController

    def sub_categories
      @sub_categories = current_store.store_material_categories.find(params[:id]).sub_categories.order("created_at desc")
    end

  end
end
