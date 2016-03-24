class Kucun::DepotsController < Kucun::BaseController
  def materials
    @store=current_store
    @store_depot = @store.store_depots.find(params[:id])
    @inventories = @store_depot.store_material_inventories
                               .joins(:store_material)
                               .by_primary_category(params[:root_category_id])
                               .by_sub_category(params[:category_id])
                               .keyword(params[:keyword])
                               .order('id asc')
    if params[:root_category_id].present?
      @root_category = @store.store_material_categories.find(params[:root_category_id])
    end
  end
end
