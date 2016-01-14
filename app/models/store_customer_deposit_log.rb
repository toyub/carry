class StoreCustomerDepositLog < ActiveRecord::Base
  belongs_to :store_customer
  belongs_to :store_order
  belongs_to :store

  before_create :set_balance

  def profit?
    type == "StoreCustomerDepositIncome"
  end

  def self.income_times
    where(type: "StoreCustomerDepositIncome").count
  end

  def self.expense_times
    where(type: "StoreCustomerDepositExpense").count
  end

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
