
class CreateStoreOrderItems < ActiveRecord::Migration
  def change
    create_table "store_order_items", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "quantity",                                               default: 0
      t.decimal  "price",                         precision: 10, scale: 4, default: 0.0
      t.decimal  "amount",                        precision: 12, scale: 4, default: 0.0
      t.string   "remark",            limit: 255
      t.integer  "orderable_id",                                                         null: false
      t.string   "orderable_type",    limit: 60,                                         null: false
      t.integer  "store_id",                                                             null: false
      t.integer  "store_chain_id",                                                       null: false
      t.integer  "store_staff_id",                                                       null: false
      t.integer  "store_order_id"
      t.integer  "store_customer_id"
     end

     add_index "store_order_items", ["orderable_id"], name: "orderable", using: :btree
     
  end
end
