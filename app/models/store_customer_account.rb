class StoreCustomerAccount
  def initialize(customer)
    @customer = customer
    @entity = customer.store_customer_entity
  end

  def as_json(*args)
    {
      balance: @entity.balance,
      credit_limit: '-',
      reward_points: '-'
    }
  end

  def to_json(*args)
    self.as_json.to_json
  end
end
