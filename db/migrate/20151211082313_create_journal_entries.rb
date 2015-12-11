class CreateJournalEntries < ActiveRecord::Migration
  def change
    create_table :journal_entries do |t|
      t.string    :party_type
      t.integer   :party_id
      t.decimal   :balance,       precision: 10,              scale: 2

      t.datetime  :created_at
      t.datetime  :updated_at
    end
  end
end
