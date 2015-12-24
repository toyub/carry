class Crm::StoreRepaymentsController < Crm::BaseController
  before_action :set_customer

  def index
  end

  private

    def set_customer
      @customer = current_user.store_customers.find(params[:store_customer_id])
    end
end
