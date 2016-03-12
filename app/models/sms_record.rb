class SmsRecord < ActiveRecord::Base
  belongs_to :store_customers

  scope :by_store, -> { where(party_type: 'Store') }
  scope :by_date, -> (start_date, end_date){ where(created_at: start_date .. end_date) }
  scope :by_category, ->(first_category, second_category) { where(first_category: first_category).where(second_category: second_category) }
  belongs_to :party, polymorphic: true
end
