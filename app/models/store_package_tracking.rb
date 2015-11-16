class StorePackageTracking < ActiveRecord::Base
  include BaseModel

  belongs_to :store_package
end
