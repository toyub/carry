class Kucun::PhysicalInventoriesController < Kucun::ControllerBase
  def index

  end

  def new
    @store = current_store
    if params[:store_depot_id].present?
      @inventories = StoreMaterialInventory.includes(:store_material)
                                           .where(store_id: @store.id,
                                                  store_depot_id: params[:store_depot_id])
      @inventories = @inventories.where('quantity > 0') if params[:nz]
    else
      @inventories = []
    end
  end

  def create
    render json: params
  end
end