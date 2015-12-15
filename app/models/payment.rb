class Payment < ActiveRecord::Base
  belongs_to :party, polymorphic: true
  has_one :debit
  validates :party_type, :party_id, presence: true
end
