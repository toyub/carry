module Ajax
  class StoreMaterialCategoriesController < Ajax::BaseController
    respond_to :json, :js

    def sub_categories
      @sub_categories = current_store.store_material_categories.find(params[:id]).sub_categories.order("created_at desc")
      respond_with @sub_categories
    end

  end
end
