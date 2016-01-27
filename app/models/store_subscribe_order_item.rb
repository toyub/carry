class StoreSubscribeOrderItem < ActiveRecord::Base
  include BaseModel

  belongs_to :itemable, polymorphic: true
  belongs_to :store_subscribe_order
end
