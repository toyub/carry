module Printer
  class BaseController < ApplicationController
    before_action :login_required
    layout 'a4printer'
  end
end
