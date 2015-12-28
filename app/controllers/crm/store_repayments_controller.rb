class Crm::StoreRepaymentsController < Crm::BaseController
  before_action :set_customer
  before_action :set_created_date, :set_limit, :action_params, only: [:index, :finished, :all]

  def index
    @q = @customer.orders.pay_hanging.ransack(params[:q])
    set_show
  end

  def create
    repayment = StoreRepayment.create(append_store_attrs({amount: @total}))
    creator = CreateRepaymentService.new(form_params, @customer, repayment)
    if creator.call
      redirect_to crm_store_customer_store_repayments_path(@customer), notice: "回款成功!"
    else
      render :index, notice: '回款失败!'
    end
  end

  def finished
    @q = @customer.orders.pay_finished.where(hanging: true).ransack(params[:q])
    set_show
  end

  def all
    @q = @customer.orders.where(hanging: true).ransack(params[:q])
    set_show
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
      params.require(:repayment).permit(:total, orders: [])
    end

    def repayment_params
      params.require(:repayment).permit(:store_id, :store_chain_id, :store_staff_id)
    end

    def set_limit
      @count = 1
    end

    def action_params
      @action = params[:action].gsub("index","")
    end

    def set_show
      if params[:count]
        @count = params[:count].to_i + 1
      end
      @orders = @q.result.order("id asc").limit(@count)
    end
end
