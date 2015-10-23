class Kucun::ShrinkagesController < Kucun::ControllerBase
  def index
    @store = current_store
    @shrinkages = StoreMaterialShrinkage.where(store_id: @store.id)
  end

  def new
    @store = current_store
  end

  def create

    shrinkage = StoreMaterialShrinkage.new(shrinkage_params)
    shrinkage.numero = ApplicationController.helpers.make_numero('S')
    ActiveRecord::Base.transaction do
      shrinkage.items.each do |item|
        item.prior_quantity = item.store_material_inventory.quantity
        item.store_staff_id = shrinkage.store_staff_id
        item.cost_price = item.store_material.cost_price
        item.inventory_cost_price = item.store_material_inventory.cost_price
        item.amount = item.quantity * item.cost_price

        shrinkage.total_quantity += item.quantity
        shrinkage.total_amount += item.amount

        item.store_material_inventory.outing!(item.quantity)
      end
      shrinkage.save!
    end
    redirect_to action: 'index'
  end

  private
  def shrinkage_params
    safe_params = params.require(:shrinkage).permit(:remark,
                                    items_attributes: [:store_material_id, :quantity,
                                                       :remark, :store_material_inventory_id, :store_depot_id])
    safe_params.merge!({
      store_staff_id: current_user.id
    })
    safe_params
  end
end
