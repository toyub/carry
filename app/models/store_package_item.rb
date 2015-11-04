class StorePackageItem < ActiveRecord::Base
  include BaseModel

  belongs_to :package_itemable, polymorphic: true
end
