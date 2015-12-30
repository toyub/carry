module Printer
  class BaseController < ApplicationController
    before_action :login_required
    layout 'printer'
  end
end