class CreateAccountReportService
  def initialize(store, accountant_date = Time.now.last_month)
    @store = store
    @accountant_date = accountant_date
  end

  def income
    hanging_customers.each do |customer|
      opening_balance(customer)
      hanging_amount_by_month = customer.orders.by_month(@accountant_date).available.pay_hanging.pluck(:amount).sum
      payment_amount_by_month = customer.store_repayments.by_month(@accountant_date).pluck(:amount).sum
      receivable_by_month = hanging_amount_by_month  - payment_amount_by_month
      hanging_amount = customer.orders.available.pay_hanging.pluck(:amount).sum
      payment_amount = customer.store_repayments.pluck(:amount).sum
      receivable = hanging_amount  - payment_amount
      closing_balance = receivable_by_month  - payment_amount_by_month
      StoreAccountReceivableReport.create!(store_id: @store.id,
                                           store_chain_id: @store.id,
                                           openings: {
                                             balance: opening_balance(customer)
                                           },
                                           accruals: {
                                             current_receivable: receivable_by_month,
                                             current_received: payment_amount_by_month
                                           },
                                           closings: {
                                             balance: closing_balance,
                                             receivable: receivable,
                                             received: payment_amount
                                           },
                                           account_id: customer.id,
                                           account_type: "StoreCustomer"
                                          )
    end
  end

  def opening_balance(customer)
    hanging_amount_by_last_month = customer.orders.by_month(@accountant_date.last_month).available.pay_hanging.pluck(:amount).sum
    payment_amount_by_last_month = customer.store_repayments.by_month(@accountant_date.last_month).pluck(:amount).sum
    receivable_by_last_month = hanging_amount_by_last_month  - payment_amount_by_last_month
    last_month_closing_blance = receivable_by_last_month  - payment_amount_by_last_month
    if last_month_closing_blance.present?
      last_month_closing_blance
    else
      0.0
    end
  end

  def hanging_customers
    customers = []
    @store.store_customers.each do |c|
      customers << c if c.orders.pluck(:hanging).include?(true)
    end
    customers
  end

end
