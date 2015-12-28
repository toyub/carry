class StoreCustomerSettlement < ActiveRecord::Base
  belongs_to :store_customer_entity

  def credit_able?
    self.credit
  end
end
