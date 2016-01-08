class Ais::OrderItemsController < Ais::BaseController
  def index
    # 后台暂未修改StoreServiceCategory对应成ServiceCategory, 
    # 且目前测试数据只有StoreServiceCategory才有，所以等修改
    # 完成之后直接用Category来查找对应的销售类别
    @category = StoreServiceCategory.find(params[:category_id])
    @order_items = @category.order_items
  end
end
