class Crm::ExpenseRecordsController < Crm::BaseController
  before_action :set_customer, :emu, only: [:index]
  def index
    @q = @customer.orders.ransack(params[:q])
    @orders = @q.result.order(id: 'desc').includes(:store_vehicle)
  end

  private
  def emu
    @complaint_categories = Complaint::CATEGORY
    @complaint_ways = Complaint::WAY
  end

  def set_customer
    @customer = StoreCustomer.find(params[:store_customer_id])
  end
end
