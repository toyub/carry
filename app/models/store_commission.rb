class StoreCommission < ActiveRecord::Base
  include BaseModel

  belongs_to :ownerable, polymorphic: true
  has_many :store_commission_items
end
