#Simple OA
module Soa
  class ControllerBase < ApplicationController
    before_filter :login_required
  end
end