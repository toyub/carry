class Sas::CustomersController < Sas::BaseController
  def index
    @store = Store.find_by_id(params[:store_id]) || current_store
  end
end
