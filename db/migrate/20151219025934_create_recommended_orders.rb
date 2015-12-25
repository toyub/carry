class CreateRecommendedOrders < ActiveRecord::Migration
  def change
    create_table :recommended_orders do |t|
      t.integer :store_id
      t.integer :store_chain_id
      t.integer :store_staff_id
      t.decimal :amount
      t.text  :remark
      t.integer :store_customer_id
      t.integer :store_vehicle_id
      t.integer :state
      t.string  :numero
      t.string :recommended_reason
      t.string :refuse_reason
      t.datetime :recommended_date

      t.timestamps null: false
    end
  end
end
