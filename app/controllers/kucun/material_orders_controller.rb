class Kucun::MaterialOrdersController < Kucun::BaseController

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
    if order_params[:items_attributes].blank?
      redirect_to action: 'new', params: {store_supplier_id: params[:store_supplier_id]}
      return false
    end
    @store = current_user.store
    store_supplier = @store.store_suppliers.find(params[:store_supplier_id])
    order = StoreMaterialOrder.new(order_params)
    ActiveRecord::Base.transaction do
      order.store_id = @store.id
      order.store_chain_id = @store.store_chain_id
      order.store_staff_id = current_user.id
      order.store_supplier_id = store_supplier.id
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
      if order_params[:payments_attributes].present?
        order.paid_amount += order_params[:payments_attributes][0][:amount].to_f
      end
      order.save!
    end
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
    safe_params = params.require(:store_material_order)
                        .permit(:remark,
                                items_attributes:[:store_material_id, :quantity, :price, :remark],
                                payments_attributes:[:amount, :store_settlement_account_id])
    safe_params[:payments_attributes][0][:store_staff_id] = current_user.id
    safe_params[:payments_attributes][0][:store_supplier_id] = params[:store_supplier_id]
    safe_params.delete(:payments_attributes) if safe_params[:payments_attributes][0][:amount].to_f < 1
    safe_params
  end
end
