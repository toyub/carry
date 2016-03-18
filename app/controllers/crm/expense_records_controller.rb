class Crm::ExpenseRecordsController < Crm::BaseController
  before_action :set_customer, :enmu, :set_search_params, only: [:index]
  def index
    @q = @customer.orders.ransack(params[:q])
    @orders = @q.result.order(id: 'desc').includes(:store_vehicle)
  end

  private
  def set_search_params
    params[:q] = {created_at_lteq: ""} unless params[:q]
    if params[:q][:created_at_lteq].present?
      params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_time.end_of_day
    end
  end

  def enmu
    @complaint_categories = Complaint::CATEGORY
    @complaint_ways = Complaint::WAY
  end

  def set_customer
    @customer = StoreCustomer.find(params[:store_customer_id])
  end
end
