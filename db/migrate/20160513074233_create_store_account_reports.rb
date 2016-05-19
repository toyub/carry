class CreateStoreAccountReports < ActiveRecord::Migration
  def change
    create_table :store_account_reports do |t|
      t.integer :store_id,  null: false
      t.integer :store_chain_id,  null: false
      t.json :openings
      t.json :accruals
      t.json :closings
      t.string :type
      t.string :account_type
      t.integer :account_id
      t.string :created_month, length: 10

      t.timestamps null: false


    end

    add_index :store_account_reports, :created_month
  end
end
