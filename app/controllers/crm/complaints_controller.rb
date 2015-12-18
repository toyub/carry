class Crm::ComplaintsController < Crm::BaseController
  def index
    # binding.pry
    store_customer = StoreCustomer.find(params[:store_customer_id])
    @complaints = store_customer.complaints
  end
end
