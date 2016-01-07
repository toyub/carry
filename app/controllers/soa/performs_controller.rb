class Soa::PerformsController < Soa::BaseController
  before_action :search_month, only: :search

  def index
    @staff = current_store.store_staff.find(params[:staff_id])
    @order_items = @staff.store_order_items.by_month(Time.now)
  end

  def search
    @staff = current_store.store_staff.find(params[:staff_id])
    if %w[materials services all].include? params[:category]
      @order_items = @staff.store_order_items.send(params[:category])
    else
      @order_items = @staff.store_order_items
    end
    @order_items = @order_items.by_month(@date)
    render :index
  end

  private
  def search_month
    @date = Date.today
    if params["date(1i)"] && params["date(2i)"]
      @date = Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i
    end
    @month = @date.strftime("%Y%m")
  end
end
