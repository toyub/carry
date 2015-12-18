class AddPartyToDebit < ActiveRecord::Migration
  def change
    add_column :debits, :party_type, :string
    add_column :debits, :party_id,   :integer
    remove_column :debits, :journal_entry_id, :integer
  end
end
