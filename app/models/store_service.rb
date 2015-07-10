class StoreService < ActiveRecord::Base
  scope :of_store, ->( store_id ) { where(store_id: store_id) }
end
