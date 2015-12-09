
class CreateStoreOrders < ActiveRecord::Migration
  def change
    create_table "store_orders", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "store_id",                                                             null: false
      t.integer  "store_chain_id",                                                       null: false
      t.integer  "store_staff_id",                                                       null: false
      t.decimal  "amount",                        precision: 12, scale: 4, default: 0.0
      t.string   "remark",            limit: 255
      t.integer  "store_customer_id"
      t.integer  "store_vehicle_id"
      t.integer  "state"
     end
  end
end
