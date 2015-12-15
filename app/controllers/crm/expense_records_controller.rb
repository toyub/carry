class Crm::ExpenseRecordsController < Crm::BaseController
  before_action :set_customer
  def index
    @orders =  
    @customer.orders
  end

  private
  def set_customer
    @customer = StoreCustomer.find(1)
  end
end
