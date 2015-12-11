class AddDebitIdToPayments < ActiveRecord::Migration
  def change
    add_column  :payments, :debit_id, :integer
  end
end
