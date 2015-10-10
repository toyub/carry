class Kucun::PhysicalInventoriesController < Kucun::ControllerBase
  def index

  end

  def new
    @store = current_store
    
    now = Time.now
    month = now.strftime('%Y%m')
    pandianri = 28
    if now.day > pandianri
      render text: '盘点日已经过了'
      return false
    end

    if params[:store_depot_id].present?
      @physical = StorePhysicalInventory.where(store_depot_id: params[:store_depot_id])
                                        .where(created_month: month)
                                        .first
      if @physical.present?
        @ids = @physical.items.select(:store_inventory_id).map(&:store_inventory_id)
      else
        @ids = []
      end

      @inventories = StoreMaterialInventory.includes(:store_material)
                                           .where(store_id: @store.id,
                                                  store_depot_id: params[:store_depot_id])
                                           
      @inventories = @inventories.where('store_material_inventories.id not in (?)', @ids)
      @inventories = @inventories.where('quantity > 0') if params[:nz]

    else
      @inventories = []      
    end
  end

  def review
    @store = current_store
    now = Time.now
    month = now.strftime("%Y%m")
    @physical = StorePhysicalInventory.where(store_depot_id: params[:store_depot_id])
                                      .where(created_month: month)
                                      .first
    
    if @physical.present?
      @inventory_count = StoreMaterialInventory.where(store_depot_id: params[:store_depot_id])
                                             .count(:id)
      @physical_count = @physical.items.count(:id)
    end
  end

  def create
    if params[:store_physical_inventories][:items_attributes].blank?
      render 'Error'
      return false
    end

    now = Time.now
    month = now.strftime("%Y%m")
    @physical = @physical = StorePhysicalInventory.where(store_depot_id: physical_params[:store_depot_id])
                                      .where(created_month: month)
                                      .first
    if @physical.present?
      @physical.items.build(physical_params[:items_attributes])
    else
      @physical = StorePhysicalInventory.new(physical_params)
      @physical.store_staff_id = current_user.id
    end
    
    @physical.items.each do |item|
      item.store_staff_id = @physical.store_staff_id
      item.status = 1 if item.inventory == item.physical
      item.diff = item.physical - item.inventory
    end
    @physical.save!
    redirect_to review_kucun_physical_inventories_path(store_depot_id:@physical.store_depot_id)
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