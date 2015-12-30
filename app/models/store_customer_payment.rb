class StoreCustomerPayment < ActiveRecord::Base
  belongs_to :store_customer
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id

  def hanging?
    self.payment_method_type == PaymentMethods::Internalcredit.name
  end

  def payment_method
    self.payment_method_type.constantize.as_json
  end
end
