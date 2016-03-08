#Just In Time
class Kucun::CheckinsController < Kucun::BaseController
  def index
    @items = StoreMaterialCheckinItem.where(store_id: current_store.id).order('id desc')
  end

  def new
    @store = current_store
  end

  def create
    @checkin = StoreMaterialCheckin.new(checkin_params)
    @log = nil
    ActiveRecord::Base.transaction do
      @checkin.quantity = 0
      @checkin.amount = 0
      @checkin.items.each do |item|
        inventory = StoreMaterialInventory.find_or_initialize_by(store_depot_id: @checkin.store_depot_id,store_material_id: item.store_material_id)
        if inventory.store_staff_id.blank?
          inventory.store_staff_id = current_user.id
          inventory.save
        end
        item.store_depot_id = @checkin.store_depot_id
        item.store_material_inventory_id = inventory.id
        item.prior_quantity = inventory.quantity
        item.prior_cost_price = inventory.cost_price
        item.amount = item.quantity * item.price
        @checkin.quantity += item.quantity
        @checkin.amount += item.amount      
      end
      @checkin.save!

      @checkin.items.each do |item|
        inventory = item.store_material_inventory
        @log = InventoryService.new(inventory, current_user).income!(item.quantity, item.cost_price).loggable!(item)
        item.latest_cost_price =  @log.closings.symbolize_keys[:inventory_cost_price]
        inventory.cost_price = @log.closings.symbolize_keys[:inventory_cost_price]
        inventory.store_material.cost_price = @log.closings.symbolize_keys[:material_cost_price]
        inventory.quantity  = @log.closings.symbolize_keys[:inventory_quantity]
        inventory.save!
        inventory.store_material.save!
      end
    end
    
    redirect_to action: 'index'
  end

  private
  def checkin_params
    safe_params = params.require(:store_material_order).permit(:remark, :store_depot_id,
                                                 items_attributes: [:store_material_id,:price,:quantity,:remark])
    safe_params.merge!(store_staff_id: current_user.id)
    safe_params[:items_attributes].each do |item_hash|
      item_hash.merge!(store_staff_id: current_user.id)
    end
    safe_params
  end
end
