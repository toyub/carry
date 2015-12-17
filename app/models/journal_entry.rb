class JournalEntry < ActiveRecord::Base

  belongs_to :journalable, polymorphic: true
  belongs_to :party, polymorphic: true

  validates :journalable_id, :journalable_type, :party_type, :party_id, presence: true
end
