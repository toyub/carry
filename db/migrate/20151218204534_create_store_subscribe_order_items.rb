class CreateStoreSubscribeOrderItems < ActiveRecord::Migration
  def change
    create_table :store_subscribe_order_items do |t|
      t.integer :store_subscribe_order_id
      t.integer :quantity
      t.integer :itemable_id
      t.string  :itemable_type

      t.timestamps null: false
    end
  end
end
