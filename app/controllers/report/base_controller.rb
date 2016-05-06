module Report
  class BaseController < ApplicationController
    before_filter :login_required
  end
end
