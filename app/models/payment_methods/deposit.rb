module PaymentMethods
  class Deposit
    include PaymentMethods::Base
    def self.cn_name
      '储值余额'
    end
  end
end
