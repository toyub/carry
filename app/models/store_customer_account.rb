class StoreCustomerAccount
  def initialize(customer)
    @customer = customer
    @entity = customer.store_customer_entity
    @settlement = @entity.store_customer_settlement
  end

  def as_json(*args)
    {
      balance: @entity.try(:balance),
      points: @entity.try(:points),
      credit_able: @settlement.try(:creditable?),
      credit_line: @settlement.try(:credit_line),
      human_readable_credit_line: @settlement.try(:human_readable_credit_line)
    }
  end

  def to_json(*args)
    self.as_json.to_json
  end
end
