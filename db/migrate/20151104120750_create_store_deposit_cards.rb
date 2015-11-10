class CreateStoreDepositCards < ActiveRecord::Migration
  def change
    create_table :store_deposit_cards do |t|
      t.decimal :price, precision: 10, scale: 2
      t.decimal :denomination, precision: 10, scale: 2
      t.string :name
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id

      t.timestamps null: false
    end
  end
end
