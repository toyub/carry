class SmsRecord < ActiveRecord::Base
  belongs_to :store_customers
  belongs_to :store

  scope :by_store, -> { where(party_type: 'Store') }
end
