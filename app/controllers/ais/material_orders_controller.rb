class Ais::MaterialOrdersController < Ais::BaseController
  def index
    @material_orders = current_store.store_material_orders.order("id desc")
  end

  def show
    @material_order = current_store.store_material_orders.find_by_id(params[:id])
  end

  def update
    @material_order = current_store.store_material_orders.find_by_id(params[:id])
    @material_order.update!(material_order_param)
  end

  private
  def material_order_param
  end
end
