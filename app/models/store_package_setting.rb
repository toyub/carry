class StorePackageSetting < ActiveRecord::Base
  include BaseModel

  belongs_to :store_package
  has_many :items, class_name: 'StorePackageItem', dependent: :delete_all

  accepts_nested_attributes_for :items, allow_destroy: true

  PERIOD_UNIT = {
    0 => '年',
    1 => '月',
    2 => '日'
  }

  def valid_date
    "#{self.period}#{PERIOD_UNIT[self.period_unit]}"
  end


end
