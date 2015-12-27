module Api
  class StoreCustomerAccountsController < BaseController
    def show
      store_customer = StoreCustomer.find(params[:id])
      render json: store_customer
    end
  end
end