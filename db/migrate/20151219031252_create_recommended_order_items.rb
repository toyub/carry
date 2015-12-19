class CreateRecommendedOrderItems < ActiveRecord::Migration
  def change
    create_table :recommended_order_items do |t|
      t.integer :recommended_order_id
      t.integer :quantity
      t.decimal :price
      t.decimal :amount
      t.integer :itemable_id
      t.string  :itemable_type

      t.timestamps null: false
    end
  end
end
