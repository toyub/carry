class StoreCustomer < ActiveRecord::Base
  include BaseModel

  has_many :store_customer_payments

  belongs_to :store_customer_entity
  before_save :set_full_name

  def province
    self.district[:province]
  end

  def mobile
    @phone_number
  end

  def satisfaction
    0
  end

  def integrity
    99
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
