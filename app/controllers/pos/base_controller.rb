module Pos
  class BaseController < ApplicationController
    before_action :login_required
  end
end
