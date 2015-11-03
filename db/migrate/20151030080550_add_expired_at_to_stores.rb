class AddExpiredAtToStores < ActiveRecord::Migration
  def change
    add_column :stores, :expired_at, :datetime
    add_column :stores, :balance, :decimal
  end
end
