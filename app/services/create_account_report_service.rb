class CreateAccountReportService
  include Serviceable

  def initialize(store, accountant_date = Time.now.last_month)
    @store = store
    @accountant_date = accountant_date
    @created_month = @accountant_date.strftime("%Y%m")
  end

  def call
    income
    payment_to_supplier
  end

  private
  def income
    hanging_customers.each do |customer|
      receivable_opening_balance(customer)
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
                                             balance: receivable_opening_balance(customer)
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
                                           created_month: @created_month,
                                           account_id: customer.id,
                                           account_type: "StoreCustomer"
                                          )
    end
  end


  def payment_to_supplier
    payable_suppliers.each do |supplier|
      payment_opening_balance(supplier)
      amount_by_month = supplier.store_material_orders.by_month(@accountant_date).pluck(:amount).sum
      paid_amount_by_month = supplier.store_material_orders.by_month(@accountant_date).pluck(:paid_amount).sum
      payable_by_month = amount_by_month - paid_amount_by_month
      closing_balance = payable_by_month - paid_amount_by_month
      amount = supplier.store_material_orders.pluck(:amount).sum
      paid_amount = supplier.store_material_orders.pluck(:paid_amount).sum
      payable = amount - paid_amount

      StoreAccountPayableReport.create!(
        store_id: @store.id,
        store_chain_id: @store.store_chain_id,
        openings: {
          balance:  payment_opening_balance(supplier)
        },
        accruals: {
          current_payable: payable_by_month,
          current_paid: paid_amount_by_month
        },
        closings: {
          balance: closing_balance,
          payable: payable,
          paid: paid_amount
        },
        created_month: @created_month,
        account_id: supplier.id,
        account_type: "StoreSupplier"
      )
    end
  end

  def receivable_opening_balance(customer)
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

  def payment_opening_balance(supplier)
    amount_by_last_month = supplier.store_material_orders.by_month(@accountant_date.last_month).pluck(:amount).sum
    paid_amount_by_last_month = supplier.store_material_orders.by_month(@accountant_date.last_month).pluck(:paid_amount).sum
    payable_by_last_month = amount_by_last_month - paid_amount_by_last_month
    last_month_closing_blance = payable_by_last_month - paid_amount_by_last_month
  end

  def hanging_customers
    customers = []
    @store.store_customers.each do |customer|
      customers << customer if customer.orders.pluck(:hanging).include?(true)
    end
    customers
  end

  def payable_suppliers
    suppliers = []
    @store.store_suppliers.each do |supplier|
      suppliers << supplier if supplier.store_material_orders.present?
    end
    suppliers
  end

end
