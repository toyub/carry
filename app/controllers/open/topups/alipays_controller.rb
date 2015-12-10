module Open
  class Topups::AlipaysController < Open::BaseController
    def new
      render json: params
    end
  end
end
