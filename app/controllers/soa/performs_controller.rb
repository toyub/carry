class Soa::PerformsController < Soa::BaseController
  before_action :search_month, only: [:index]

  def index
  end

  private
  def search_month
    @staff = current_store.store_staff.find(params[:staff_id])
    @date = Date.today
    if params["date(1i)"] && params["date(2i)"]
      @date = Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i
    end

    if @date < Time.now.at_beginning_of_month
      @commission_items = @staff.commission_items.by_month(@date)
      @commission_items = @commission_items.by_type(params[:category]) if params[:category].present? && params[:category] != 'all'
    else
      @order_items = (@staff.store_order_items.where.not(orderable_type: StoreMaterialSaleinfoService.name).joins(:store_order).by_month(@date) unless params[:category] == 'constructed') || []
      if @staff.mechanic? && params[:category] != 'sale'
        items = current_store.store_order_items.joins(:store_staff_tasks).where(store_staff_tasks: {store_staff_id: @staff.id}).by_month(@date)
        @order_items += items if items.present?
        @order_items.uniq!
      end
      @orders_count = @order_items.size
    end
  end
end
