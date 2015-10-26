
class CreateStores < ActiveRecord::Migration
  def change
    create_table "stores", force: :cascade do |t|
      t.integer  "store_chain_id",                            null: false
      t.integer  "admin_id"
      t.string   "name",            limit: 60,                null: false
      t.integer  "business_status",            default: 0
      t.integer  "payment_status",             default: 0
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
