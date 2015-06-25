class Kucun::MaterialOrdersController < Kucun::ControllerBase
  def new
    @store = current_user.store
    @store_materials = @store.store_materials.all
    @store_material_order = @store.store_material_orders.new
    @supplier = @store.store_suppliers.find(params[:store_supplier_id])
  end

  #New Order With An Unkown Supplier => nowaus
  def nowaus
    @store = current_user.store
    @store_materials = @store.store_materials.all
    @store_material_order = @store.store_material_orders.new
  end

  def create
    @store = current_user.store
    _order_params = order_params
    _order_params[:store_material_order_items_attributes].delete_if { |key, value| !value[:checked] }
    order = StoreMaterialOrder.new(_order_params)

    order.store_id = @store.id
    order.store_chain_id = @store.store_chain_id
    order.store_staff_id = current_user.id
    order.store_supplier_id = 1
    order.numero = Time.now.strftime('%Y%m%d%H%M%S')
    order.amount = 0.0
    order.store_material_order_items.each do |item|
      item.store_id = order.store_id
      item.store_chain_id = order.store_chain_id
      item.store_staff_id = order.store_staff_id
      item.store_supplier_id = order.store_supplier_id
      #item.price = item.store_material.cost_price
      item.amount = item.price * item.quantity
      order.amount += item.amount
    end

    order.save
    #render json: order.as_json.merge({items: order.store_material_order_items})
    redirect_to '/kucun/materials/'
  end

  def show
    respond_to do |format|
      order = StoreMaterialOrder.joins(store_material_order_items: [:store_material]).pending.find(params[:id])
      format.html { render text: 'html' }
      format.json { render json: order.as_json.merge({
          items: order.store_material_order_items.pending.map{|item| item.as_json.merge({material: item.store_material.as_json})  }
        })
      }
    end
  end

  def order_params
    params.require(:store_material_order).permit(store_material_order_items_attributes:[:store_material_id, :checked, :quantity, :price])
  end
end
