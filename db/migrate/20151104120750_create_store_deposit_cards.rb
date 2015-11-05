class CreateStoreDepositCards < ActiveRecord::Migration
  def change
    create_table :store_deposit_cards do |t|
      t.decimal :price, precision: 10, scale: 2
      t.decimal :denomination, precision: 10, scale: 2
      t.string :name

      t.timestamps null: false
    end
  end
end
