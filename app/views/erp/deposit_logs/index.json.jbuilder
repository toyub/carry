json.logs @deposit_logs do |log|
  json.(log, :balance, :amount)
  json.(log.store_order, :numero)
  json.store_name log.store.name
  json.created_at log.created_at.strftime('%Y-%m-%d')
  json.amount_symbol log.methematical_symbol
end
json.income_times StoreCustomerDepositLog.income_times
json.expense_times StoreCustomerDepositLog.expense_times
json.current_balance StoreCustomerDepositLog.last.balance
