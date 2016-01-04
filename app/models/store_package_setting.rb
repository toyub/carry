class StorePackageSetting < ActiveRecord::Base
  include BaseModel

  belongs_to :store_package
  has_many :items, class_name: 'StorePackageItem', dependent: :delete_all

  accepts_nested_attributes_for :items, allow_destroy: true

  
end
