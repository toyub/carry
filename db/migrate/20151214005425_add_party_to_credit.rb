class AddPartyToCredit < ActiveRecord::Migration
  def change
    add_column :credits, :party_type, :string
    add_column :credits, :party_id,   :integer
    remove_column :credits, :journal_entry_id, :integer
  end
end
