class StoreDepositPackageItemable < ActiveRecord::Base
  include BaseModel

  has_many :store_package_items, as: :package_itemable
end
