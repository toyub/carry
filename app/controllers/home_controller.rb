class HomeController < ApplicationController
  layout "advancev1"
  before_filter :login_required
  before_action :get_works, only: [:show]

  def show
    @orders = current_store.today_orders
    @order_items = current_store.today_order_items
    @complaints = current_store.today_complaints
    @store_trackings = current_store.today_trackings
    @todos = current_user.todos.order("id desc")
  end


  private
  def get_works
    @works = (YAML.load_file Rails.root.join("config", "my_work.yml")).with_indifferent_access[:works]
  end
end
