class AddJournalableToJournalEntries < ActiveRecord::Migration
  def change
    add_column :journal_entries, :journalable_type, :string
    add_column :journal_entries, :journalable_id, :integer
  end
end
