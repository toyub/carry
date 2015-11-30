class StoreCustomer < ActiveRecord::Base
  include BaseModel

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
