module Entities
  class DepositLog < Grape::Entity
    expose :logs do |customer, options|
      customer.deposit_logs.map do |log|
        {
          balance: log.balance,
          amount: log.amount,
          numero: log.store_order.try(:numero),
          store_name: log.store.name,
          created_at: log.created_at.strftime('%Y-%m-%d'),
          amount_symbol: log.methematical_symbol
        }
      end
    end
    # expose :income_times do
    #   StoreCustomerDepositLog.income_times
    # end

    # expose :expense_times, StoreCustomerDepositLog.expense_times
    # expose :current_balance, StoreCustomerDepositLog.last.try(:balance)

  end
end
