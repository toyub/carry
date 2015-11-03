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

      @inventories = @store.store_material_inventories
                           .inclmd
                           .by_depot(params[:store_depot_id])

      @inventories = @inventories.where('store_material_inventories.id not in (?)', @ids) if @ids.present?
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

  def loss_report
    @store = current_store
    @physical = StorePhysicalInventory.where(store_id: @store.id, id: params[:physical_id]).first

    outing = StoreMaterialOuting.new(outing_params)
    outing.total_quantity=0
    outing.total_amount = 0

    ActiveRecord::Base.transaction do
      outing.items.each do |item|
        inventory = item.store_material_inventory
        item.store_staff_id = outing.store_staff_id
        item.outing_type_id = outing.outing_type_id
        item.cost_price = item.store_material.cost_price
        item.amount = item.cost_price * item.quantity
        item.inventory_cost_price = inventory.cost_price
        item.requester_id = outing.requester_id

        outing.total_quantity += item.quantity
        outing.total_amount += item.amount
        inventory.outing!(item.quantity)
      end
      outing.save!
      StorePhysicalInventoryItem.where(id: params[:physical_items]).update_all(status: 1)
    end
    redirect_to review_kucun_physical_inventories_path(store_depot_id: @physical.store_depot_id)
  end

  def profit_report
    @store = current_store
    @physical = StorePhysicalInventory.where(store_id: @store.id, id: params[:physical_id]).first
    checkin = StoreMaterialCheckin.new(checkin_params)

    ActiveRecord::Base.transaction do
      checkin.items.each do |item|
        item.store_staff_id = checkin.store_staff_id
        inventory = item.store_material_inventory
        item.prior_quantity = inventory.quantity
        item.prior_cost_price = inventory.cost_price
        item.latest_cost_price = inventory.store_material.cost_price
        item.price = inventory.cost_price
        item.amount = item.quantity * item.price
        checkin.quantity += item.quantity
        checkin.amount += item.amount
        inventory.checkin!(item.quantity)
      end
      checkin.save!
      StorePhysicalInventoryItem.where(id: params[:physical_items]).update_all(status: 1)
    end
    redirect_to review_kucun_physical_inventories_path(store_depot_id: @physical.store_depot_id)
  end

  private
  def physical_params
    params.require(:store_physical_inventories)
          .permit(:store_depot_id,
                  items_attributes:[:store_material_id, :store_depot_id, :store_inventory_id,
                                    :inventory, :physical, :inventory_cost_price, :cost_price, :remark])
  end

  def outing_params
    safe_params = params.require(:outing).permit(:requester_id, :outing_type_id, :remark,
                                    items_attributes: [:store_material_id, :quantity,
                                                       :remark, :store_material_inventory_id, :store_depot_id])
    safe_params.merge!({
      store_staff_id: current_user.id
    })
    safe_params
  end

  def checkin_params
    safe_params = params.require(:checkin).permit(:remark,
                                    items_attributes: [:store_material_id, :quantity,
                                                       :remark, :store_material_inventory_id, :store_depot_id])
    safe_params.merge!({
      store_staff_id: current_user.id
    })
    safe_params
  end
end