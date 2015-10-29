
class CreateStoreServiceReminds < ActiveRecord::Migration
  def change
    create_table "store_service_reminds", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "store_id",                     null: false
      t.integer  "store_chain_id",               null: false
      t.integer  "store_staff_id",               null: false
      t.string   "content",          limit: 255
      t.integer  "trigger_timing"
      t.integer  "mode"
      t.integer  "delay_interval"
      t.boolean  "notice_required"
      t.integer  "store_service_id"
      t.boolean  "enable"
     end
  end
end
