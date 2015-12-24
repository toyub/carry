class StoreOrderArchive
  def initialize(payments_hash, order)
    @payments_hash = payments_hash
    @order = order
    @customer = order.store_customer
  end

  def reform()

    ActiveRecord::Base.transaction do
      save_payments
      pay_finish
      create_debit
    end

  end

  def save_payments
    amount = @payments_hash.map { |payment| payment[:amount] }.sum
    raise ActiveRecord::Rollback unless @order.amount.to_f == amount
    @payments = @order.store_customer_payments.create!(@payments_hash)
  end

  def pay_finish
    
  end

  def create_debit
    puts "\n"*8
    p @order.deposits_cards
    puts "---------------------------------------------------------------"
    puts "\n" * 8
  end

  def create_credit(order)
    StoreCustomerCredit(store_id: order.store_id,
                        store_chain_id: order.store_chain_id,
                        store_customer_id: order.store_customer_id,
                        store_order_id: order.id,
                        amount: decimal,
                        created_at: datetime,
                        updated_at: datetime)
  end

  def recombine
    p @order.revenue_ables
    p @order.deposits_cards
    p @order.taozhuangs
  end
end
