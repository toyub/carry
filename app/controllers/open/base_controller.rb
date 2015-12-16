module Open
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token
    layout "open"
  end
end
