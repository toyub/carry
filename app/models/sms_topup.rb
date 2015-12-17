class SmsTopup
  PRICE = 0.06
  def initialize(quantity)
    @quantity = quantity
    @topup_type = TopupType.find_by_name('短信费用')
  end

  def self.find(id)
    TopupType.find(id)
  end

  def to_h
    {
      orderable_id: self.orderable_id,
      orderable_type: self.orderable_type,
      quantity: self.quantity,
      price: self.price,
      amount: self.quantity * self.price
    }
  end

  def orderable_id
    @topup_type.id
  end

  def orderable_type
    self.class.name
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

  def payment_method
    ['支付宝', '网银'].sample
  end
end
