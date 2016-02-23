class StoreCustomerEntity < ActiveRecord::Base
  include BaseModel

  has_one :store_customer, dependent: :destroy
  has_one :store_customer_settlement, dependent: :destroy
  belongs_to :store_customer_category

  accepts_nested_attributes_for :store_customer
  accepts_nested_attributes_for :store_customer_settlement

  enum property: %w[personal company]

  def settlement_payment_method
    self.settlement
  end

  def district
    read_attribute(:district) || {}
  end

  def category
    self.store_customer_category.try(:name)
  end

  def district
    read_attribute(:district) || {}
  end

  def province
    self.district["province"]
  end

  def city
    self.district["city"]
  end

  def region
    self.district["region"]
  end

  def creditable?
    self.store_customer_settlement.creditable?
  end

  def filling_date
    self.created_at.strftime("%Y-%m-%d")
  end

  def property_name
    self.property_i18n
  end

  def property_i18n
    if self.property.present?
      I18n.t self.property, scope: [:enums, :store_customer_entity, :property]
    else
      '未定义'
    end
  end

  def category
    self.store_customer_category.try(:name)
  end

  def settlement
    self.store_customer_settlement.try(:payment_mode_i18n)
  end

  def increase_balance!(amount)
    self.class.unscoped.where(id: self.id).update_all("balance=COALESCE(balance, 0) + #{amount.to_f.abs}")
  end

  def decrease_balance!(amount)
    self.class.unscoped.where(id: self.id).update_all("balance=COALESCE(balance, 0) - #{amount.to_f.abs}")
  end

  def increase_points!(quantity)
    self.class.unscoped.where(id: self.id).update_all("points=COALESCE(points, 0) + #{quantity.to_i.abs}")
  end

  def membership!
     self.membership = true
     self.save!
  end

end
