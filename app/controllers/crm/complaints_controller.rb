class Crm::ComplaintsController < Crm::BaseController
  before_action :set_customer, only: [:index]
  def index
    # binding.pry
    @q = @customer.complaints.ransack(params[:q])
    @complaints = @q.result.includes(:store_vehicle)
  end

  private
  def set_customer
    @customer = StoreCustomer.find(params[:store_customer_id])
  end
end
