class StorePackageSetting < ActiveRecord::Base
  include BaseModel

  belongs_to :store_package
  has_many :items, class_name: 'StorePackageItem', dependent: :delete_all
  before_save :set_retail_price

  accepts_nested_attributes_for :items, allow_destroy: true

  PERIOD_UNIT = {
    0 => '年',
    1 => '月',
    2 => '日'
  }

  def set_retail_price
    self.retail_price = self.items.inject{ |sum, item| sum + item.quantity * item.price }
  end

  def valid_date
    "#{self.period}#{PERIOD_UNIT[self.period_unit]}"
  end

  def services
    self.items.packaged_services
  end

  def contains_service
    self.services.length > 0
  end

end
