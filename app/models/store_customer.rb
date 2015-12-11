class StoreCustomer < ActiveRecord::Base
  include BaseModel

  belongs_to :store_customer_entity
  before_save :set_full_name

  def province
    self.district[:province]
  end

  def city
    self.district[:city]
  end

  def region
    self.district[:region]
  end

  private

    def set_full_name
      if first_name_changed? || last_name_changed?
        self.full_name = first_name + last_name
      end
    end
end
