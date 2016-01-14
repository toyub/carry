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

end
