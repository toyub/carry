class Sas::CustomersController < Sas::BaseController
  def index
    @store = current_store
  end
end
