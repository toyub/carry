class StorePackage < ActiveRecord::Base
  include BaseModel

  has_many :uploads, class_name: '::Upload::Base', as: :fileable, dependent: :destroy
  has_one :package_setting, class_name: 'StorePackageSetting', dependent: :destroy
  has_many :trackings, class_name: 'StorePackageTracking', dependent: :destroy

  after_create :create_one_setting

  def create_one_setting
    self.create_package_setting(creator: self.creator)
  end
end
