class Crm::StoreRepaymentsController < Crm::BaseController
  before_action :set_customer
  before_action :set_created_date, only: [:index]

  def index
    @q = @customer.orders.where(pay_status: 0).ransack(params[:q])
    @orders = @q.result(distinct: true).order("id asc")
    # respond_with @repayments, location: nil
    # StoreOrder.all.each do |order|
    #   order.update(pay_status: 0, filled: 0)
    # end
  end

  def show
    @repayment = @customer.store_repayments.find(params[:id])
  end

  def create
    total = form_params[:total].to_i
    repayment = StoreRepayment.create(append_store_attrs({amount: total}))
    @customer.orders.where(id: form_params[:orders]).each do |order|
      remaining = total - order.repayment_remaining
      if remaining >= 0
        total = remaining
        order.repayment_finished!
        order.store_order_repayments.create(filled: order.repayment_remainning, remaining: 0.0, store_repayment: repayment)
      else
        order.update(filled: order.filled + total)
        order.store_order_repayments.create(filled: total, remaining: order.repayment_remaining, store_repayment: repayment  )
        break
      end
    end
    redirect_to crm_store_customer_store_repayments_path(@customer), notice: "回款成功!"
  end


  private
    def set_created_date
      if params[:created_at].present?
        params[:q][:created_at_lt] = params[:created_at].to_time.end_of_day
        params[:q][:created_at_gt] = params[:created_at].to_time.beginning_of_day
      end
    end

    def set_customer
      @customer = StoreCustomer.find(params[:store_customer_id])
    end

    def form_params
      params.require(:repayment).permit(:total,
          orders: []
          )
    end

    def repayment_params
      params.require(:repayment).permit(:store_id, :store_chain_id, :store_staff_id)
    end

    def repayment_order(id)
      StoreOrder.find(id)
    end

end
