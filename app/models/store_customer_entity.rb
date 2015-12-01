class StoreCustomerEntity < ActiveRecord::Base
  include BaseModel

  has_one :store_customer
  has_one :store_customer_settlement

  accepts_nested_attributes_for :store_customer
  accepts_nested_attributes_for :store_customer_settlement
end
