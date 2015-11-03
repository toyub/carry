
class CreateStoreSubscribeOrders < ActiveRecord::Migration
  def change
    create_table "store_subscribe_orders", force: :cascade do |t|
      t.integer  "store_id"
      t.integer  "store_chain_id"
      t.integer  "store_staff_id"
      t.string   "remark",            limit: 255
      t.integer  "store_customer_id"
      t.integer  "vehicle_id"
      t.datetime "subscribe_date"
      t.integer  "state"
      t.integer  "order_type"
      t.datetime "created_at",                    null: false
      t.datetime "updated_at",                    null: false
     end
  end
end
