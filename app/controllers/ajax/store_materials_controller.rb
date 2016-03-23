module Ajax
  class StoreMaterialsController < Ajax::BaseController

    respond_to :json, :js

    ## TODO: store_material已经将root_category冗余了进来，下一个版本考虑更改
    def index
      @store_materials = current_store.store_materials.name_contains(params[:name])
      if params[:sub_category].present?
        @store_materials = @store_materials.by_sub_category(params[:sub_category])
      elsif params[:primary_category].present?
        @store_materials = @store_materials.joins(:store_material_category).where("store_material_categories.parent_id = ?", params[:primary_category])
      end

      respond_with @store_materials
    end

    def inventories
      if params[:depot_id].blank?
        respond_with []
        return false
      end
      search_scope = StoreMaterialInventory.joins(:store_material, :store_depot).where(store_depot_id: params[:depot_id])
      search_scope = search_scope.where('store_materials.name like ?', "%#{params[:name]}%") if params[:name].present?
      search_scope = search_scope.where('store_materials.store_material_root_category_id = ?', params[:root_category_id]) if params[:root_category_id].present?
      search_scope = search_scope.where('store_materials.store_material_category_id = ?', params[:category_id]) if params[:category_id].present?
      respond_with search_scope.all
    end

  end
end
