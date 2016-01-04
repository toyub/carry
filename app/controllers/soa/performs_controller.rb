class Soa::PerformsController < Soa::BaseController
  def index
    @staff = current_store.store_staff.find(params[:staff_id])
    @order_items = @staff.store_order_items
  end

  def search
  end

  def show
  end
end
