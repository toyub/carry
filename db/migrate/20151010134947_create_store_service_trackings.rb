
class CreateStoreServiceTrackings < ActiveRecord::Migration
  def change
    create_table "store_service_trackings", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "store_id",                                     null: false
      t.integer  "store_chain_id",                               null: false
      t.integer  "store_staff_id",                               null: false
      t.integer  "store_service_id"
      t.integer  "mode",                         default: 1
      t.boolean  "notice_required",              default: false
      t.string   "content",          limit: 255
      t.integer  "delay_interval",               default: 0
      t.integer  "delay_unit"
      t.integer  "trigger_timing"
     end
  end
end
