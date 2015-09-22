class Kucun::MaterialOrdersController < Kucun::ControllerBase

  def index
    @store = current_user.store
    @store_supplier = @store.store_suppliers.find(params[:store_supplier_id])
    @store_material_orders = @store.store_material_orders.where(store_supplier_id: @store_supplier.id)
  end

  def new
    @store = current_user.store
    @store_materials = @store.store_materials.all
    @store_material_order = @store.store_material_orders.new
    @store_supplier = @store.store_suppliers.find(params[:store_supplier_id])
  end

  #New Order With An Unkown Supplier => nowaus
  def nowaus
    @store = current_user.store
    @store_material_order = @store.store_material_orders.new
    @store_material = @store.store_materials.find(params[:material_id]) if params[:material_id].present?
  end

  def create
    @store = current_user.store
    store_supplier = @store.store_suppliers.find(params[:store_supplier_id])

    order = StoreMaterialOrder.new(order_params)
    order.store_id = @store.id
    order.store_chain_id = @store.store_chain_id
    order.store_staff_id = current_user.id
    order.store_supplier_id = store_supplier.id
    order.numero = ApplicationController.helpers.make_numero("MO")
    order.amount = 0.0
    order.items.each do |item|
      item.store_id = order.store_id
      item.store_chain_id = order.store_chain_id
      item.store_staff_id = order.store_staff_id
      item.store_supplier_id = order.store_supplier_id
      item.amount = item.price * item.quantity
      order.amount += item.amount
      order.quantity += item.quantity
    end
    order.save
    redirect_to kucun_store_supplier_material_orders_path({store_supplier_id: order.store_supplier_id})
  end

  def show
    respond_to do |format|
      order = StoreMaterialOrder.joins(items: [:store_material]).pending.find(params[:id])
      format.html { render text: 'html' }
      format.json { render json: order.as_json}
    end
  end

  def order_params
    params.require(:store_material_order).permit(items_attributes:[:store_material_id, :quantity, :price])
  end
end
