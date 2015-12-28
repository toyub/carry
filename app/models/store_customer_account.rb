class StoreCustomerAccount
  def initialize(customer)
    @customer = customer
    @entity = customer.store_customer_entity
    @settlement = @entity.store_customer_settlement
  end

  def as_json(*args)
    {
      balance: @entity.balance,
      points: @entity.points,
      credit_able: @settlement.creditable?,
      credit_line: @settlement.credit_line,
      human_readable_credit_line: @settlement.human_readable_credit_line
    }
  end

  def to_json(*args)
    self.as_json.to_json
  end
end
