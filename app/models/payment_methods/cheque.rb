module PaymentMethods
  class Cheque
    include PaymentMethods::Base
    def self.cn_name
      '支票'
    end

    def self.enumable_name
      'cheque'
    end
  end
end
