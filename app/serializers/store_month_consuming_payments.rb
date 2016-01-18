class StoreMonthConsumingPayments
  attr_reader :data

  def initialize(payments)
    set_data(payments)
  end

  def self.to_json
    @data
  end

  private

  def set_data(payments)
    total_count = payments.count.to_f
    cash= payments.payment_method("PaymentMethods::Cash").count / total_count
    backcard = payments.payment_method("PaymentMethods::Bankcard").count / total_count
    alipay = payments.payment_method("PaymentMethods::Alipay").count / total_count
    wechatpay = payments.payment_method("PaymentMethods::Wechatpay").count / total_count

    @data = [
      {value: cash, name: PaymentMethods::Cash.hashable[:cn_name] },
      {value: backcard, name: PaymentMethods::Bankcard.hashable[:cn_name] },
      {value: alipay, name: PaymentMethods::Alipay.hashable[:cn_name] },
      {value: wechatpay, name: PaymentMethods::Wechatpay.hashable[:cn_name] }
    ]
  end

end
