class StoreCustomerCategory < ActiveRecord::Base
  include BaseModel
  validates_presence_of :name
end
