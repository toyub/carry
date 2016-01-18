class SmsRecord < ActiveRecord::Base
  belongs_to :store_customers
  belongs_to :store
end
