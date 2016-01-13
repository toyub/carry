class Ais::OrderItemsController < Ais::BaseController
  def index
    @category = Category.find(params[:category_id])
    @order_items = @category.order_items
  end
end
