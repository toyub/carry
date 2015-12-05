class StoreCustomerEntity < ActiveRecord::Base
  include BaseModel

  has_one :store_customer
  has_one :store_customer_settlement

  accepts_nested_attributes_for :store_customer
  accepts_nested_attributes_for :store_customer_settlement

  def province
    self.district["province"]
  end

  def city
    self.district["city"]
  end

  def region
    self.district["region"]
  end

  def filling_date
    self.created_at.strftime("%Y-%m-%d")
  end
end
