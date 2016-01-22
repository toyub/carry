module Entities
  class DepositLogInfo < Grape::Entity
    expose :income_times
    expose :expense_times
    expose :current_balance
    expose :deposit_logs, using: ::Entities::DepositLog

    private

      def income_times
        StoreCustomerDepositLog.income_times
      end

      def expense_times
        StoreCustomerDepositLog.expense_times
      end

      def current_balance
        StoreCustomerDepositLog.last.try(:balance)
      end
  end
end
