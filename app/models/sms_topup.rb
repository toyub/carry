class SmsTopup
  PRICE = 0.06
  def initialize(quantity)
    @quantity = quantity
  end

  def amount
    PRICE * @quantity
  end

  def quantity
    @quantity
  end

  def price
    PRICE
  end

  def created_at
    @created_at ||= rand(10).days.ago
  end

  def payment_method
    ['支付宝', '网银'].sample
  end
end
