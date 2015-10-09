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
    if params[:store_physical_inventories][:items_attributes].blank?
      render 'Error'
      return false
    end
    
    @physical = StorePhysicalInventory.new(physical_params)
    render json: {
      p: @physical,
      items: @physical.items
    }
  end

  private
  def physical_params
    params.require(:store_physical_inventories)
          .permit(:store_depot_id, 
                  items_attributes:[:store_material_id, :store_depot_id, :store_inventory_id, :inventory, :physical, :remark])
  end
end