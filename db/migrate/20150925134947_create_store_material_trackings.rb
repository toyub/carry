
class CreateStoreMaterialTrackings < ActiveRecord::Migration
  def change
    create_table "store_material_trackings", force: :cascade do |t|
      t.integer  "store_id",                          null: false
      t.integer  "store_chain_id",                    null: false
      t.integer  "store_staff_id",                    null: false
      t.integer  "store_material_id",                 null: false
      t.boolean  "enabled",           default: false, null: false
      t.integer  "tracking_mode",     default: 0,     null: false
      t.boolean  "reminder_required", default: false, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
