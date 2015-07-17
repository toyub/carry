module Ajax
  class StoreMaterialsController < Ajax::BaseController

    def index
      store_materials = current_store.store_materials.name_contains(params[:name])
      if params[:sub_category].present?
        store_materials = store_materials.by_sub_category(params[:sub_category])
      elsif params[:primary_category].present?
        store_materials = store_materials.joins(:store_material_category).where("store_material_categories.parent_id = ?", params[:primary_category])
      end

      respond_with store_materials
    end

  end
end
