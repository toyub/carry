module Kucun
  class ControllerBase < ApplicationController
    before_filter :login_required
  end
end