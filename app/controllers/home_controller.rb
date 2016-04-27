class HomeController < ApplicationController
  layout "advancev1"
  before_filter :login_required

  def show
    @orders = current_store.today_orders
    @order_items = current_store.today_order_items
    @complaints = current_store.today_complaints
  end

end
