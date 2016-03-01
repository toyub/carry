class StoreCustomerSettlement < ActiveRecord::Base
  belongs_to :store_customer_entity

  enum credit: %w[unpermitted custom unlimited ]
  enum notice_period: %w[_3days _5days _7days]
  enum payment_mode: PaymentMethods.available_methods_enumables
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
    if self.credit
      I18n.t self.credit, scope: [:enums, :store_customer_settlement, :credit]
    else
      '未定义'
    end
  end

  def notice_period_i18n
    if self.notice_period
      I18n.t self.notice_period, scope: [:enums, :store_customer_settlement, :notice_period]
    else
      '未定义'
    end
  end

  def payment_mode_i18n
    if self.payment_mode
      I18n.t self.payment_mode, scope: [:enums, :store_customer_settlement, :payment_mode]
    else
      '未定义'
    end
  end

  def invoice_type_i18n
    if self.invoice_type
      I18n.t self.invoice_type, scope: [:enums, :store_customer_settlement, :invoice_type]
    else
      '未定义'
    end
  end
end
