module Receipt
  class BaseController < ApplicationController
    before_action :login_required
    layout 'receipt'
  end
end
