module PaymentMethods
  def self.available_methods

  [
    PaymentMethods::Alipay.hashable,
    PaymentMethods::Bankcard.hashable,
    PaymentMethods::Cash.hashable,
    PaymentMethods::Cheque.hashable,
    PaymentMethods::Deposit.hashable,
    PaymentMethods::Internalcredit.hashable,
    PaymentMethods::Wechatpay.hashable
  ].to_h

  end

  module Base
    module ClassMethods
      def hashable
        [self.name, self.cn_name]
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
