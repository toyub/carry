class StoreChain <  ActiveRecord::Base
  has_many :stores
  belongs_to :head_office, class_name: 'Store', foreign_key: :admin_store_id
end
