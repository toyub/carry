class Order
  def initialize(topup, subject)
    @amount = topup.amount
    @subject = subject
  end

  def amount
    @amount
  end

  def subject
    @subject
  end

  def numero
    "#{Time.now.strftime('%Y%m%d')}#{rand(1000).to_s.rjust(6, '0')}"
  end
end
