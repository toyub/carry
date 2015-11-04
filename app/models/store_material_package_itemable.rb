class StoreMaterialPackageItemable < ActiveRecord::Base
  include BaseModel

  has_many :store_package_items, as: :package_itemable
  belongs_to :store_material
end
