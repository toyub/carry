module PaymentMethods
  def self.available_methods
     [
        PaymentMethods::Cash.hashable,
        PaymentMethods::Bankcard.hashable,
        PaymentMethods::Cheque.hashable,
        PaymentMethods::Alipay.hashable,
        PaymentMethods::Wechatpay.hashable,        
        PaymentMethods::Deposit.hashable,
        PaymentMethods::Internalcredit.hashable
      ]
  end

  module Base
    module ClassMethods
      def hashable
        {name: self.name, cn_name: self.cn_name}
      end

      def as_json(*args)
        {name: self.name, cn_name: self.cn_name}
      end
    end

    module InstanceMethods

    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end

end
