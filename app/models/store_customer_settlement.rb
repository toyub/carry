class StoreCustomerSettlement < ActiveRecord::Base
  belongs_to :store_customer_entity

  def creditable?
    self.credit.present? && self.credit.to_s != "unpermitted"
  end

  def credit_line
    if creditable?
      self.credit_limit.to_f - self.credit_bill_amount.to_f
    else
      0
    end
  end
end
