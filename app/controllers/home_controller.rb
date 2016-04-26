class HomeController < ApplicationController
  layout "advancev1"
  before_filter :login_required

  def show
  end

end
