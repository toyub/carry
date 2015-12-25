class StoreCustomerDepositLog < ActiveRecord::Base
  belongs_to :store_customer

  before_create :set_balance

  private
  def set_balance
    case self.type
    when StoreCustomerDepositIncome.name
      self.balance = self.latest.to_f + self.amount.to_f.abs
    when StoreCustomerDepositExpense.name
      self.balance = self.latest.to_f - self.amount.to_f.abs
    else
      self.errors.add(:type, "<class:#{self.class}> 是无效的记录类型", valid_class: [StoreCustomerDepositIncome.name, StoreCustomerDepositExpense.name])
      raise ActiveRecord::Rollback, "uninitialized deposit log type #{self.class}"
    end
  end
end
