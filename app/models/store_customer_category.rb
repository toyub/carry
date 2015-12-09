class StoreCustomerCategory < ActiveRecord::Base
  include BaseModel

  has_many :store_customers

  validates_presence_of :name
end
