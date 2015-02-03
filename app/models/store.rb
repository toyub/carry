class Store <  ActiveRecord::Base
  belong_to :store_chain
  validates :name, presence: true
end