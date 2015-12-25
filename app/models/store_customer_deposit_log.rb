class StoreCustomerDepositLog < ActiveRecord::Base
  belongs_to :store_customer

  before_create :set_balance

  private
  def set_balance
    case self.class
    when StoreCustomerDepositIncome
      self.balance = self.latest.to_f + card.amount.to_f.abs
    when StoreCustomerDepositExpense
      self.balance = self.latest.to_f - card.amount.to_f.abs
    else
      raise ActiveRecord::Rollback, "uninitialized deposit log type #{self.class}"
    end
  end
end
