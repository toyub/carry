class StoreCustomerSettlement < ActiveRecord::Base
  belongs_to :store_customer_entity

  enum credit: %w[unpermitted custom unlimited ]
  enum notice_period: %w[_3days _5days _7days]
  enum payment_mode: %w[cash check debit alipay wechat hanging credit_card]
  enum invoice_type: %w[common extra]

  def creditable?
    !self.unpermitted?
  end

  def human_readable_credit_line
    if creditable?
      if self.unlimited?
        '不限金额'
      else
        credit_line
      end
    else
      '不能挂账'
    end
  end

  def credit_line
    if self.unlimited?
      Float::INFINITY.to_s
    else
      self.credit_limit.to_f - self.credit_bill_amount.to_f
    end
  end

  def increase_credit_bill_amount!(amount)
    self.class.unscoped.where(id: self.id).update_all("credit_bill_amount=COALESCE(credit_bill_amount, 0) + #{amount.to_f.abs}")
  end

  def credit_i18n
    I18n.t "enums.store_customer_settlement.credit.#{self.credit}"
  end

  def notice_period_i18n
    I18n.t "enums.store_customer_settlement.notice_period.#{self.notice_period}"
  end

  def payment_mode_i18n
    I18n.t "enums.store_customer_settlement.payment_mode.#{self.payment_mode}"
  end

  def invoice_type_i18n
    I18n.t "enums.store_customer_settlement.invoice_type.#{self.invoice_type}"
  end
end
