module PaymentMethods
  class Cash
    include PaymentMethods::Base
    def self.cn_name
      '现金'
    end

    def self.enumable_name
      'cash'
    end
  end
end
