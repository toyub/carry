class OrderItem < ActiveRecord::Base
  belongs_to :order

  def orderable
    self.orderable_type.constantize.find(self.orderable_id)
  end

  def payment_method
    ['支付宝', '网银'].sample
  end

end
