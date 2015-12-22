class CreateStoreCustomerSettlements < ActiveRecord::Migration
  def change
    create_table :store_customer_settlements do |t|
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id
      t.string :bank
      t.string :bank_account
      t.string :credit
      t.string :credit_amount
      t.string :notice_period
      t.string :contract
      t.string :tax
      t.string :payment_mode
      t.string :invoice_type
      t.string :invoice_title

      t.timestamps null: false
    end
  end
end
