class Crm::StoreAssetsController < Crm::BaseController
  def index
    @customer = StoreCustomer.find(params[:store_customer_id])
  end

  def show
    @customer = StoreCustomer.find(params[:store_customer_id])
    @patial = "packages_consume_history"

    respond_to do |format|
      format.js
    end
  end
end
