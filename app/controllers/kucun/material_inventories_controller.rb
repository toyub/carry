class Kucun::MaterialInventoriesController < Kucun::ControllerBase
  def index
  end

  def new
    @store = current_user.store
    @store_material_orders = @store.store_material_orders.pending.all
  end

  def create
    store = current_user.store
    order = store.store_material_orders.find(params[:order_id])
    order_process = 0
    excess_items = []
    excess_order = nil

    ActiveRecord::Base.transaction do
      order.store_material_order_items.where(id: params[:items].keys).each do |item|
        item_params = params[:items][item.id.to_s]
        if item.quantity == item_params[:received_quantity].to_f
          item.all_receive
        elsif item.quantity < item_params[:received_quantity].to_f
          excess_item = item.all_receive_and_reorder_excess(item_params[:received_quantity].to_f)
          excess_items.push({item:excess_item, store_depot_id: item_params[:store_depot_id]})
        else
          item.partially_receive(item_params[:received_quantity].to_f)
        end
        item.put_in_depot!(item_params[:store_depot_id])
        order_process += item.process
      end
      if excess_items.present?
        excess_order = StoreMaterialOrder.create({
            store_id: order.store_id,
            store_chain_id: order.store_chain_id,
            store_staff_id: order.store_staff_id,
            store_supplier_id: order.store_supplier_id,
            numero: make_numero("MO"),
            remark: "#{Time.now.to_s(:date_only)} 临时补订货物"
        })
        excess_order.amount = 0.0
        excess_items.each do |item_hash|
          item = item_hash[:item]
          store_depot_id = item_hash[:store_depot_id]
          item.received_quantity = item.quantity
          item.remark = excess_order.remark
          item.returned_quantity = 0
          item.process = (((item.received_quantity + item.returned_quantity)/item.quantity.to_f) * 100).to_i
          excess_order.store_material_order_items.push(item)
          excess_order.amount += item.amount
          item.put_in_depot!(store_depot_id)
        end
        excess_order.process = 100
        excess_order.save
      end
      order.process = order_process/order.store_material_order_items.length
      order.save
    end

    redirect_to action: :new
  end
end
