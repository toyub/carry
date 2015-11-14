class StoreDepositCard < ActiveRecord::Base
  has_many :store_package_items, as: :package_itemable
end
