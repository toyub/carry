class StoreOrderArchive
  def initialize(payments_hash, order)
    @payments_hash = payments_hash
    @order = order
    @customer = order.store_customer
  end

  def reform

    
      save_payments
      pay_finish
      save_deposit_cards
      create_debit
    

  end

  def save_payments
    amount = @payments_hash.map { |payment| payment[:amount] }.sum
    raise ActiveRecord::Rollback unless @order.amount.to_f == amount
    @payments = @order.store_customer_payments.create!(@payments_hash)
  end

  def pay_finish
    #@order.pay_finished!
  end

  def save_deposit_cards
     @order.deposits_cards.each do |card|
        StoreCustomerDepositCard.create! store_id: @order.store_id,
                                         store_customer_id: @order.store_customer_id,
                                         store_vehicle_id: @order.store_vehicle_id,
                                         items_attributes: [{store_id: @order.store_id,
                                                             store_chain_id: @order.store_chain_id,
                                                             store_customer_id: @order.store_customer_id,
                                                             assetable: card,
                                                             total_quantity: 1,
                                                             used_quantity: 1}]

        StoreCustomerDepositIncome.create! store_id: @order.store_id,
                                           store_chain_id: @order.store_chain_id,
                                           store_customer_id: @order.store_customer_id,
                                           store_vehicle_id: @order.store_vehicle_id,
                                           store_order_id: @order.id,
                                           latest: @customer.store_customer_entity.balance.to_f,
                                           amount: card.denomination.to_f

        @customer.store_customer_entity.increase_balance!(card.denomination)
     end
  end

  def save_package_items
  end

  def create_credit
    StoreCustomerCredit(store_id: @order.store_id,
                        store_chain_id: @order.store_chain_id,
                        store_customer_id: @order.store_customer_id,
                        store_order_id: @order.id,
                        amount: @order.amount)
  end

  def create_debit
    true
  end

  def recombine
    p @order.revenue_ables
    p @order.deposits_cards
    p @order.taozhuangs
  end
end
