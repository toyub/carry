class StoreCustomerPayment < ActiveRecord::Base
  belongs_to :store_customer

  def hanging?
    self.payment_method_type == PaymentMethods::Internalcredit.name
  end
end
