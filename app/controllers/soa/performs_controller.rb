class Soa::PerformsController < Soa::BaseController
  before_action :search_month, only: [:index, :search]

  def index
  end

  def search
    render :index
  end

  private
  def search_month
    @date = Date.today
    if params["date(1i)"] && params["date(2i)"]
      @date = Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i
    end
    @staff = current_store.store_staff.find(params[:staff_id])
    @order_items = @staff.store_order_items.joins(:store_order).by_month(@date)
    @order_items = @order_items.send(params[:category]) if params[:category].present?
    @orders_count = @order_items.group(:store_order_id).count.size
  end
end
