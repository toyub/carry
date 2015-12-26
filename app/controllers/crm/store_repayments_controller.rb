class Crm::StoreRepaymentsController < Crm::BaseController
  before_action :set_customer

  def index

    @q = @customer.store_repayments.ransack(params[:q])
    @repayments = @q.result(distinct: true).order("id desc")
    # respond_with @repayments, location: nil
  end

  def show
    @repayment = @customer.store_repayments.find(params[:id])
  end

  private

    def set_customer
      @customer = StoreCustomer.find(params[:store_customer_id])
    end
end
