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
      @commission_items = @staff.store_commission_items.by_month(@date)
      @commission_items = @commission_items.by_type(params[:category]) if params[:category].present? && params[:category] != 'all'
    else
      if @staff.commission?
        @order_items = (@staff.store_order_items.joins(:store_order).where(from_customer_asset: false).by_month(@date).order("id desc") unless params[:category] == 'constructed') || []
        if @staff.mechanic? && params[:category] != 'sale'
          if @staff.current_month_regulared?
            items = current_store.store_order_items.joins(:store_staff_tasks).where("store_staff_tasks.created_at > ?", @staff.regular_protocal.effected_on).where(store_staff_tasks: {mechanic_id: @staff.id})
          else
            items = current_store.store_order_items.joins(:store_staff_tasks).where(store_staff_tasks: {mechanic_id: @staff.id}).by_month(@date)
          end
          @order_items += items if items.present?
          @order_items.uniq!
        end
      end
    end
  end
end
