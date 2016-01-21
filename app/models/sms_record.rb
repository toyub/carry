class SmsRecord < ActiveRecord::Base
  belongs_to :store_customers
  belongs_to :store

  scope :by_store, -> { where(party_type: 'Store') }
  belongs_to :party, polymorphic: true
end
