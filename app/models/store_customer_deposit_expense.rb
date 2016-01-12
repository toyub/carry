class StoreCustomerDepositExpense < StoreCustomerDepositLog
  def self.expense!(store_customer, order, amount)
    if order.paid?
      return {valid: true, paid: true}
    end
    if store_customer.store_customer_entity.balance < amount
      return {valid: true, paid: false, msg: '账号余额不足，不能使用储值支付'}
    end

    self.create store_id: order.id,
                store_chain_id: order.store_chain_id,
                store_customer_id: store_customer.id,
                store_vehicle_id: order.store_vehicle_id,
                store_order_id: order.id,
                subject: "消费付款",
                latest: store_customer.store_customer_entity.balance,
                amount: amount,
                balance: store_customer.store_customer_entity.balance - amount
    store_customer.store_customer_entity.decrease_balance!(amount)
    {valid: true, paid: true}
  end

  def methematical_symbol
    'minus'
  end
end
