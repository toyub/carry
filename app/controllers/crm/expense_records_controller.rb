class Crm::ExpenseRecordsController < Crm::BaseController
  before_action :set_customer
  def index
    @q = @customer.orders.ransack(params[:q])
    @orders = @q.result.includes(:store_vehicle)
  end

  def complaint
    @store_order = StoreOrder.find(params[:order_id])
    vehicle = @store_order.store_vehicle.plates.last.license_number
    numero = @store_order.numero
    render json: {vehicle: vehicle, numero: numero}
  end


  private
  def set_customer
    @customer = StoreCustomer.find(1)
  end
end
