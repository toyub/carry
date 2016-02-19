module PaymentMethods
  class Bankcard
    include PaymentMethods::Base
    def self.cn_name
      '银行卡'
    end

    def self.enumable_name
      'bankcard'
    end
  end
end
