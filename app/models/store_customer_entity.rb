class StoreCustomerEntity < ActiveRecord::Base
  has_many :store_customers
  has_one :store_customer_settlement
end
