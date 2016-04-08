class Crm::StoreRepaymentsController < Crm::BaseController
  before_action :set_customer
  before_action :set_created_date, :set_per_page_quantity, :action_params, only: [:index, :finished, :hanging]

  def index
    @q = @customer.orders.available.where(hanging: true).ransack(params[:q])
    @orders = @q.result.order("id asc").page(params[:page]).per_page(@quantity)
    set_current_page
  end

  def create
    creator = CreateRepaymentService.new(form_params, @customer)
    if creator.call
      redirect_to hanging_crm_store_customer_store_repayments_path(@customer), notice: "回款成功!"
    else
      render :hanging, notice: '回款失败!'
    end
  end

  def finished
    @q = @customer.orders.available.pay_finished.where(hanging: true).ransack(params[:q])
    @orders = @q.result.order("id asc").page(params[:page]).per_page(@quantity)
    set_current_page
  end

  def hanging
    @q = @customer.orders.available.pay_hanging.ransack(params[:q])
    @orders = @q.result.order("id asc").page(params[:page]).per_page(@quantity)
    set_current_page
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
      form_params = params.require(:repayment).permit(:total, orders: [])
      append_attrs(form_params, store_option, staff_option, customer_option)
    end

    def set_current_page
      @current_page = @orders.current_page
    end

    def set_per_page_quantity
      @quantity = 10
    end

    def action_params
      @action = params[:action].gsub("index","")
    end

end
