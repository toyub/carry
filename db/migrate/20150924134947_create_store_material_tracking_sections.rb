
class CreateStoreMaterialTrackingSections < ActiveRecord::Migration
  def change
    create_table "store_material_tracking_sections", force: :cascade do |t|
      t.integer  "store_id",                                           null: false
      t.integer  "store_chain_id",                                     null: false
      t.integer  "store_staff_id",                                     null: false
      t.integer  "store_material_id",                                  null: false
      t.integer  "store_material_tracking_id",                         null: false
      t.integer  "timing",                                 default: 1, null: false
      t.integer  "delay_interval",                                     null: false
      t.string   "delay_unit",                 limit: 10,              null: false
      t.integer  "delay_in_seconds",                                   null: false
      t.integer  "contact_way",                            default: 1, null: false
      t.string   "content",                    limit: 255,             null: false
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
