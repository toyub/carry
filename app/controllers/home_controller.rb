class HomeController < ApplicationController
  layout "advancev1"
  before_filter :login_required

  def show
    @orders = current_store.today_orders
  end

end
