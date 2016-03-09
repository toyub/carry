class StoreCommission < ActiveRecord::Base
  belongs_to :ownerable, polymorphic: true
  has_many :store_commission_items
end
