module Xiaoshou
  class BaseController < ApplicationController
    before_filter :login_required

    private

    def default_serializer_options
      {root: false}
    end
  end
end
