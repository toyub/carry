class Credit < ActiveRecord::Base
  has_one :journal_entry, as: :journalable
  belongs_to :party, polymorphic: true

  validates :party_type, :party_id, presence: true
end
