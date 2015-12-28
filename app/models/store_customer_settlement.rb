class StoreCustomerSettlement < ActiveRecord::Base
  belongs_to :store_customer_entity

  def creditable?
    self.credit.present? && self.credit.to_s != "unpermitted"
  end

  def human_readable_credit_line
    if creditable?
      if self.credit.to_s == 'unlimited'
        '不限金额'
      else
        credit_line
      end
    else
      '不能挂账'
    end
  end

  def credit_line
    if self.credit.to_s == 'unlimited'
      Float::INFINITY.to_s
    else
      self.credit_limit.to_f - self.credit_bill_amount.to_f
    end
  end
end
