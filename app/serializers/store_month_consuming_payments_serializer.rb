class StoreMonthConsumingPaymentsSerializer < ActiveModel::Serializer
  attr_accessor :data

  def initialize(month = Time.now)
    total_count = StoreCustomerPayment.by_month(month).count.to_f
    cash= StoreCustomerPayment.by_month(month).payment_method("PaymentMethods::Cash").count / total_count
    backcard = StoreCustomerPayment.by_month(month).payment_method("PaymentMethods::Bankcard").count / total_count
    alipay = StoreCustomerPayment.by_month(month).payment_method("PaymentMethods::Alipay").count / total_count
    wechatpay = StoreCustomerPayment.by_month(month).payment_method("PaymentMethods::Wechatpay").count / total_count

    @data = [
      {value: cash, name: PaymentMethods::Cash.hashable[:cn_name] },
      {value: backcard, name: PaymentMethods::Bankcard.hashable[:cn_name] },
      {value: alipay, name: PaymentMethods::Alipay.hashable[:cn_name] },
      {value: wechatpay, name: PaymentMethods::Wechatpay.hashable[:cn_name] }
    ] 
  end

end
