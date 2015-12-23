#Statistics
module Statistics
  class BaseController < ApplicationController
    before_filter :login_required
  end
end
