class Kucun::MaterialInventoriesController < Kucun::ControllerBase
  def index
  end

  def new
    @store = current_user.store
    @store_material_orders = @store.store_material_orders.suspense.all
  end

  def create
    store = current_user.store
    order = store.store_material_orders.find(params[:order_id])
    order_process = 0
    excess_order = nil

    ActiveRecord::Base.transaction do
      smr = StoreMaterialReceipt.create(store_staff_id: current_user.id)
      order.items.where(id: params[:items].keys).each do |item|
        item_params = params[:items][item.id.to_s]
        if item.quantity == item_params[:received_quantity].to_f
          item.all_receive
        elsif item.quantity < item_params[:received_quantity].to_f
          item.excess_receive(item_params[:received_quantity].to_f)
        else
          item.partially_receive(item_params[:received_quantity].to_f)
        end
        item.put_in_depot!(item_params[:store_depot_id], smr.id)
        order_process += item.process
      end
      order.process = order_process/order.items.length
      order.save!
    end
    redirect_to action: :new
  end
end
