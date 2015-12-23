module PaymentMethods
  class Wechatpay
    include PaymentMethods::Base
    def self.cn_name
      '微信支付'
    end
  end
end
