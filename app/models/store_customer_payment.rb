class StoreCustomerPayment < ActiveRecord::Base
  belongs_to :store_customer
  belongs_to :creator, class_name: "StoreStaff", foreign_key: :store_staff_id

  scope :by_month, -> (month = Time.now) { where("created_at between ? and ?", month.at_beginning_of_month, month.at_end_of_month)}
  scope :payment_method, -> (type = "PaymentMethods::Internalcredit") { where(payment_method_type: type)}

  def hanging?
    self.payment_method_type == PaymentMethods::Internalcredit.name
  end

  def payment_method
    self.payment_method_type.constantize.as_json
  end

  def payment_method_cn_name
    self.payment_method_type.constantize.cn_name
  end
end
