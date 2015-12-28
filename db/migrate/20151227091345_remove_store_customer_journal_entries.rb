class RemoveStoreCustomerJournalEntries < ActiveRecord::Migration
  def up
    drop_table :store_customer_credits if ActiveRecord::Base.connection.table_exists?(:store_customer_credits)
    drop_table :store_customer_debits if ActiveRecord::Base.connection.table_exists?(:store_customer_debits)
    drop_table :store_customer_journal_entries if ActiveRecord::Base.connection.table_exists?(:store_customer_journal_entries)
  end
end
