
class CreateStoreMaterialLogs < ActiveRecord::Migration
  def change
    create_table "store_material_logs", force: :cascade do |t|
      t.integer  "store_id",                     null: false
      t.integer  "store_chain_id",               null: false
      t.integer  "store_staff_id",               null: false
      t.string   "store_material_id", limit: 45, null: false
      t.string   "log_type",          limit: 45
      t.text     "prior_value"
      t.text     "value"
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
