class AddPaymentIdToDebit < ActiveRecord::Migration
  def change
    add_column :debits, :payment_id, :integer
  end
end
