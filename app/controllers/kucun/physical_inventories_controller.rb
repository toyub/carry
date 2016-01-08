class Kucun::PhysicalInventoriesController < Kucun::BaseController
  before_action :set_store

  def index
    @physicals = @store.store_physical_inventories
    if params[:month].to_s =~ /^\d{4}(?:\-|\/){1}(?:0?[1-9]|1[0-2])$/
      from_date = Date.parse(params[:month].to_s.gsub(/(^\d{4})(?:\-|\/){1}(0?[1-9]|1[0-2])$/, '\1-\2') + "-01")
                      .to_time.beginning_of_day
      end_date = from_date.end_of_month.to_time.end_of_day
    else
      params[:month] = Time.now.strftime('%Y-%m')
      from_date = Time.now.beginning_of_month
      end_date = Time.now.end_of_month
    end

    @physicals = @physicals.where('created_at between :from_date and :end_date', from_date: from_date, end_date: end_date)

    if params[:store_depot_id].present?
      @physicals = @physicals.where(store_depot_id: params[:store_depot_id])
    end
  end

  def excel
    @physical = @store.store_physical_inventories.find(params[:id])
    rows = @physical.items.map do |item|
      "\"#{item.store_material.name}\",\"#{item.store_material.barcode}\",\"#{item.store_material.store_material_root_category.name}\",\"#{item.store_material.store_material_category.name}\",\"#{item.store_material.speci}\",\"#{item.store_material.store_material_unit.name}\",\"#{item.inventory}\",\"#{item.physical}\",\"#{item.diff}\",\"#{item.remark}\""
    end
    rows.unshift("\uFEFF 商品名称, 商品条码, 一级分类, 二级分类, 规格, 单位, 库存数, 盘点数, 盘盈盘亏, 备注")
    send_data rows.join("\n"), type: 'csv', filename: "库存盘点-#{@physical.store_depot.name}-#{@physical.created_at.strftime('%Y-%m')}.csv"
  end

  def new
    now = Time.now
    month = now.strftime('%Y%m')
    # pandianri = 28
    # if now.day > pandianri
    #   render text: '盘点日已经过了'
    #   return false
    # end

    if params[:store_depot_id].present?
      @physical = StorePhysicalInventory.where(store_depot_id: params[:store_depot_id])
                                        .where(created_month: month)
                                        .first
      if @physical.present?
        @ids = @physical.items.select(:store_inventory_id).map(&:store_inventory_id)
      else
        @ids = []
      end

      @inventories = @store.store_material_inventories.by_depot(params[:store_depot_id])

      @inventories = @inventories.where('store_material_inventories.id not in (?)', @ids) if @ids.present?
      @inventories = @inventories.where('quantity > 0') if params[:nz]

    else
      @inventories = []
    end
  end

  def review
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

  def checked
    @physical = StorePhysicalInventory.find(params[:id])
    if @physical.items.where(status: 0).count(:id) > 0
      render json: {error: 'There some item not checked!'}
    else
      @physical.update!(status: 1)
      redirect_to action: 'index'
    end
  end

  def create
    if params[:store_physical_inventories][:items_attributes].blank?
      render text: 'Error'
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
    @physical = StorePhysicalInventory.find(params[:id])
  end

  def loss_report
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
      end
      outing.save!
      outing.items.each do |item|
        inventory = item.store_material_inventory
        @log = InventoryService.new(inventory, current_user).outgo!(item.quantity).loggable!(item)
        inventory.outing!(item.quantity)
      end

      StorePhysicalInventoryItem.where(id: params[:physical_items]).update_all(status: 1)
    end
    redirect_to review_kucun_physical_inventories_path(store_depot_id: @physical.store_depot_id)
  end

  def profit_report
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
      end
      checkin.save!

      checkin.items.each do |item|
        inventory = item.store_material_inventory
        @log = InventoryService.new(inventory, current_user).income!(item.quantity, item.cost_price).loggable!(item)
        inventory.checkin!(item.quantity)
      end

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

  def set_store
    @store = current_store
  end
end
