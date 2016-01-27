class Api::Sas::CustomersController < Api::BaseController
  def index
    render json: Sas::CustomerPropertyCategories.new(current_store)
  end
end
