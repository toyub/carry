
class CreateStoreServiceSettings < ActiveRecord::Migration
  def change
    create_table "store_service_settings", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "store_id",                     null: false
      t.integer  "store_chain_id",               null: false
      t.integer  "store_staff_id",               null: false
      t.integer  "setting_type",     default: 0
      t.integer  "store_service_id"
     end
  end
end
