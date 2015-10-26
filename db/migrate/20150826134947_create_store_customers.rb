
class CreateStoreCustomers < ActiveRecord::Migration
  def change
    create_table "store_customers", force: :cascade do |t|
      t.integer  "store_id",                  null: false
      t.integer  "store_chain_id",            null: false
      t.integer  "store_staff_id",            null: false
      t.string   "first_name",     limit: 45, null: false
      t.string   "last_name",      limit: 45, null: false
      t.string   "full_name",      limit: 45, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "phone_number",   limit: 45
     end
  end
end
