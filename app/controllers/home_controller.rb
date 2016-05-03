class HomeController < ApplicationController
  layout "advancev1"
  before_filter :login_required

  def show
    @todos = current_user.todos.order("id desc")
    @schedules = current_user.schedules.unfinished
    @my_works = Menu.shortcuts_for(current_user)
    @today_counter = HomeCountersPresenter.new(current_store, Time.now)
    @yesterday_counter = HomeCountersPresenter.new(current_store, Time.now.yesterday)
  end

end
