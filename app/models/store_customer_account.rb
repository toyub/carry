class StoreCustomerAccount
  def initialize(customer)
    @customer = customer
    @entity = customer.store_customer_entity
    @settlement = @entity.store_customer_settlement
  end

  def as_json(*args)
    {
      credit_able: false,
      balance: @entity.balance,
      credit_limit: nil,
      points: @entity.points
    }
  end

  def to_json(*args)
    self.as_json.to_json
  end
end
