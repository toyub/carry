#Simple OA
module Soa
  class BaseController < ApplicationController
    before_filter :login_required
  end
end
