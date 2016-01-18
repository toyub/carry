class Api::Sas::CustomerGenderController < Api::BaseController
  def index
    render json: StoreCustomerGenderCategories.new(current_store)
  end
end
