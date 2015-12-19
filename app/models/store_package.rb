class StorePackage < ActiveRecord::Base
  include BaseModel
  include RandomTextable

  random :code

  has_many :uploads, class_name: 'StoreFile', as: :fileable, dependent: :destroy
  has_one :package_setting, class_name: 'StorePackageSetting', dependent: :destroy
  has_many :trackings, class_name: 'StorePackageTracking', dependent: :destroy
  has_many :store_subscribe_order_items, as: :itemable

  after_create :create_one_setting

  def create_one_setting
    self.create_package_setting(creator: self.creator)
  end

end
