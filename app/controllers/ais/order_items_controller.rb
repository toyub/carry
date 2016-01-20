class Ais::OrderItemsController < Ais::BaseController
  def index
    @category = Category.find(params[:category_id])
    date = Date.parse(params[:date])
    @order_items = @category.order_items.joins(:store_order).by_month(date)
  end
end
