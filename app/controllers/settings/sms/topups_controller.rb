module Settings
  class Sms::TopupsController < BaseController
    def index
      p params
      @topups = 6.times.map{
        SmsTopup.new(100 + rand(7)*100)
        }.sort{|x, y| x.created_at.to_i <=>  y.created_at.to_i}
    end

    def new
      if params[:quantity].to_i < 200
        render text: '参数错误'
        return false
      end
      alipay = Alipay.new(Order.new(SmsTopup.new(params[:quantity].to_i), '短信充值费用'))
      redirect_to alipay.url
    end
  end
end
