module Open
  class Topups::AlipaysController < Open::BaseController
    def return_url
      p params
      render json: params
    end

    def notify_url
      p params
      render text: 'success'
    end
  end
end
