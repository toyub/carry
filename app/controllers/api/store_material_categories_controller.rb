module Api
  class StoreMaterialCategoriesController < Api::BaseController

    def index
      @categories = current_store.root_material_categories.order("created_at desc")
      respond_with @categories
    end

  end
end
