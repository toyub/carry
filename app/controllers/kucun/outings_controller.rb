class Kucun::OutingsController < Kucun::BaseController
  def index
    @store = current_store
    @outing_items = StoreMaterialOutingItem.where(store_id: @store.id)
  end

  def new
    @store = current_store
    if params[:outing_type_id].present?
      @outing_type=OutingType.find(params[:outing_type_id].to_i)
    else
      @outing_type=OutingType.find_by_name('领用出库')
    end
  end

  def create
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
    end
    redirect_to action: 'index'
  end

  private
  def outing_params
    safe_params = params.require(:outing).permit(:requester_id, :outing_type_id, :remark, 
                                    items_attributes: [:store_material_id, :quantity,
                                                       :remark, :store_material_inventory_id, :store_depot_id])
    safe_params.merge!({
      store_staff_id: current_user.id
    })
    safe_params
  end
end
