class Api::Sas::CustomersController < Api::BaseController
  def index
    render json: StoreCustomerPropertyCategories.new(current_store)
  end
end
