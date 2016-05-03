class HomeController < ApplicationController
  layout "advancev1"
  before_filter :login_required

  def show
    @store_trackings = current_store.today_trackings
    @todos = current_user.todos.order("id desc")
    @schedules = current_user.schedules
    @my_works = Menu.shortcuts_for(current_user)
    @today_counter = HomeCountersPresenter.new(current_store, Time.now)
    @yesterday_counter = HomeCountersPresenter.new(current_store, Time.now.yesterday)
  end
end
