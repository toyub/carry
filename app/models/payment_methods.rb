module PaymentMethods
  def self.available_methods
    self.available_methods_klasses.map { |klass| klass.hashable}
  end

  def self.available_methods_names
    self.available_methods_klasses.map { |klass| klass.name}
  end

  def self.available_methods_enumables
    self.available_methods_klasses.map{|klass| klass.enumable_name}
  end

  def self.available_methods_klasses
    [PaymentMethods::Cash,
    PaymentMethods::Bankcard,
    PaymentMethods::Cheque,
    PaymentMethods::Alipay,
    PaymentMethods::Wechatpay,
    PaymentMethods::Deposit,
    PaymentMethods::Internalcredit]
  end

  module Base
    module ClassMethods
      def hashable
        {name: self.name, cn_name: self.cn_name, enumable_name: self.enumable_name}
      end

      def as_json(*args)
        self.hashable
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
