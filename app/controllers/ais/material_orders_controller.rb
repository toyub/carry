class Ais::MaterialOrdersController < Ais::BaseController
  before_action :query_material_order, only: [:index]
  def index
  end

  def show
    @material_order = current_store.store_material_orders.find_by_id(params[:id])
  end

  def update
    @material_order = current_store.store_material_orders.find_by_id(params[:id])
    @material_order.update!(withdrawal_by: current_staff.id, withdrawal_at: Time.now)
    @material_order.payments.last.update!(amount: params[:payment_amount], store_settlement_account_id: params[:account_id], order_balance: params[:order_balance])
  end

  private
  def query_material_order
    @date = Date.today
    @material_orders = current_store.store_material_orders.order("id desc")
    if params["date(1i)"] && params["date(2i)"]
      @date = Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i
    end
    @material_orders = @material_orders.by_month(@date)
  end

end
