module PaymentMethods
  class Cash
    include PaymentMethods::Base
    def self.cn_name
      '现金'
    end
  end
end
