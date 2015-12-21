class CreateStoreCustomerJournalEntries < ActiveRecord::Migration
  def change
    create_table :store_customer_journal_entries do |t|
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_customer_id
      t.string  :journalable_type
      t.integer :journalable_id
      t.decimal :amount,                precision: 10, scale: 2, default: 0

      t.timestamps null: false
    end
  end
end
