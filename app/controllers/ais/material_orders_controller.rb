class Ais::MaterialOrdersController < Ais::BaseController
  def index
    @material_orders = current_store.store_material_orders.order("id desc")
  end

  def show
    @material_order = current_store.store_material_orders.find_by_id(params[:id])
  end

  def update
    @material_order = current_store.store_material_orders.find_by_id(params[:id])
    @material_order.update!(withdrawal_by: current_staff.id, withdrawal_at: Time.now)
    @material_order.payments.last.update!(amount: params[:payment_amount], store_settlement_account_id: params[:account_id], order_balance: params[:order_balance])
  end

end
