module Api
  class BaseController < ApplicationController
    before_filter :login_required

    respond_to :json

    private

    def default_serializer_options
      {root: false}
    end
  end
end
