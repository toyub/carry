class StorePackage < ActiveRecord::Base
  include BaseModel
  include RandomTextable

  random :code

  has_many :uploads, class_name: 'StoreFile', as: :fileable, dependent: :destroy
  has_one :package_setting, class_name: 'StorePackageSetting', dependent: :destroy
  has_many :trackings, class_name: 'StorePackageTracking', dependent: :destroy
  has_many :store_subscribe_order_items, as: :itemable
  has_many :store_order_items, as: :itemable

  after_create :create_one_setting

  alias_attribute :retail_price, :price

  scope :by_month, ->(month = Time.now) {where("created_at between ? and ?", month.at_beginning_of_month, month.at_end_of_month)} 

  def create_one_setting
    self.create_package_setting(creator: self.creator)
  end

  def contain_service?
    self.package_setting.items.where(package_itemable_type: "StoreService").count > 0
  end

  def point
    self.package_setting.point
  end
  
  def vip_price
    0
  end

  def category
    ""
  end

  def self.total_amount(month = Time.now)
    amount = 0.0
    by_month(month).each do |package|
      amount += package.store_order_items.total_amount
    end
    amount
  end

end
