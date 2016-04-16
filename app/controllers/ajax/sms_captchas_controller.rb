module Ajax
  class SmsCaptchasController  < BaseController
    def create
      customer = StoreCustomer.find(params[:customer_id])
      captcha = 6.times.map(&->(i){rand(10)}).join('')
      $redis.set("sms.captcha.pos.pay-#{customer.phone_number}", captcha)
      sms_options = {
          receiver_type: StoreCustomer.name,
          receiver_id: customer.id,
          content: "尊敬的用户：你正在使用储值卡付款，本次的消费验证码为「#{captcha}」，请在15分钟内操作，切勿将验证码泄漏。<#{current_store.name}>汽车服务门店",
          first_category: SmsCaptchaSwitchType.name,
          second_category: SmsCaptchaSwitchType.find_by_name('账户余额支付验证').id
        }

      SmsJob.perform_later sms_options
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
