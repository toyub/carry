class StoreCustomer < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer_entity

  def province
    self.district[:province]
  end

  def city
    self.district[:city]
  end

  def region
    self.district[:region]
  end
end
