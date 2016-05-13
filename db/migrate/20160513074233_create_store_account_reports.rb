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

      t.timestamps null: false
    end
  end
end
