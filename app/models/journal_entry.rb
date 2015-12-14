class JournalEntry < ActiveRecord::Base
  validates :journalable_id, presence: true
  validates :journalable_type, presence: true

  belongs_to :journalable, polymorphic: true

  def self.credit
  end

  def self.debit
  end
end
