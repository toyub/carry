module Entities
  class DepositLogInfo < Grape::Entity
    expose :income_times
    expose :expense_times
    expose :current_balance
    expose :deposit_logs, using: ::Entities::DepositLog

    private

      def income_times
        object.deposit_incomes.count
      end

      def expense_times
        object.deposit_expenses.count
      end

      def current_balance
        object.deposit_logs.last.try(:balance)
      end
  end
end
