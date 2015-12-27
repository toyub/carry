class Crm::StoreAssetsController < Crm::BaseController
  def index
    @customer = StoreCustomer.find(params[:store_customer_id])
  end
end
