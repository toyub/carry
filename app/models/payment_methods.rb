module PaymentMethods
  def self.available_methods
    self.constants
  end
end
