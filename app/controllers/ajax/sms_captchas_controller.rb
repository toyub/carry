module Ajax
  class SmsCaptchasController  < BaseController
    def create
      customer = StoreCustomer.find(params[:customer_id])
      captcha = 6.times.map(&->(i){rand(10)}).join('')
      $redis.set("sms.captcha.pos.pay-#{customer.phone_number}", captcha)
      SmsJob.perform_later customer_id: customer.id,
                    content: "您本次的消费验证码为「#{captcha}」。",
                    first_category: SmsCaptchaSwitchType.name,
                    second_category: SmsCaptchaSwitchType.find_by_name('账户余额支付验证').id

      render json: params
    end

    def validate
      customer = StoreCustomer.find(params[:customer_id])
      captcha = $redis.get("sms.captcha.pos.pay-#{customer.phone_number}")
      if captcha.present? && captcha == params[:authentication_code]
        render json: {valid: true}
      else
        render json: {valid: false, msg: 'Illegal authentication code'}
      end
    end
  end
end
