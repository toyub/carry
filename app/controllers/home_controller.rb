class HomeController < ApplicationController
  layout "advancev1"
  before_filter :login_required
  before_action :get_works, :my_works, only: [:show]

  def show
    @store_trackings = current_store.today_trackings
    @todos = current_user.todos.order("id desc")
    @schedules = current_user.schedules
    @home = HomeCountersPresenter.new(current_store)
  end


  private
  def get_works
    @works = current_user.work_list
  end

  def my_works
    get_works
    @my_works = []
    if current_user.works.present?
      @works.each do |root_category|
        root_category[:sub_categories].each do |work|
          @my_works << work if current_user.works.include?(work[:idx].to_s)
        end
      end
    end
    @my_works
  end
end
