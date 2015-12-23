module PaymentMethods
  class Internalcredit
    include PaymentMethods::Base
    def self.cn_name
      '挂账'
    end
  end
end
