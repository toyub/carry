module PaymentMethods
  class Bankcard
    include PaymentMethods::Base
    def self.cn_name
      '银行卡'
    end
  end
end
