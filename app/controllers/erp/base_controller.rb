module Erp
  class BaseController < ApplicationController
    before_filter :auth_token

    respond_to :json

    private

    def default_serializer_options
      {root: false}
    end

    def auth_token
      
    end
  end
end
