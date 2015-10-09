class Kucun::PhysicalInventoriesController < Kucun::ControllerBase
  def index

  end

  def new
    @store = current_store
    
    now = Time.now
    month = now.strftime('%Y%m')

    if params[:store_depot_id].present?
      @physical = StorePhysicalInventory.where(store_depot_id: @store.id).where(created_month: month).first
      if @physical
        ids = @physical.items.map {|item| item.store_inventory_id}
      else
        ids = []
      end
      @inventories = StoreMaterialInventory.includes(:store_material)
                                           .where(store_id: @store.id,
                                                  store_depot_id: params[:store_depot_id])
                                           .where('store_material_inventories.id not in (?)', ids)
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
    @physical.store_staff_id = current_user.id
    @physical.items.each do |item|
      item.store_staff_id = @physical.store_staff_id
      item.status = 1 if item.inventory == item.physical
    end
    @physical.save!
    redirect_to edit_kucun_physical_inventory_path(@physical)
  end

  def edit
    @store = current_store
    @physical = StorePhysicalInventory.find(params[:id])
  end

  private
  def physical_params
    params.require(:store_physical_inventories)
          .permit(:store_depot_id, 
                  items_attributes:[:store_material_id, :store_depot_id, :store_inventory_id,
                                    :inventory, :physical, :inventory_cost_price, :cost_price, :remark])
  end
end