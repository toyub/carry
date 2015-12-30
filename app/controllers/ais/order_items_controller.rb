class Ais::OrderItemsController < Ais::BaseController
  def index
    @categories = StoreServiceCategory.find(params[:category_id])
    @order_items = @categories.order_items
  end
end
