class StoreSubscribeOrderItem < ActiveRecord::Base
  belongs_to :itemable, polymorphic: true
  belongs_to :store_subscribe_order
end
