
class CreateStoreMaterialSaleinfoServices < ActiveRecord::Migration
  def change
    create_table "store_material_saleinfo_services", force: :cascade do |t|
      t.integer  "store_id",                                                 null: false
      t.integer  "store_chain_id",                                           null: false
      t.integer  "store_staff_id",                                           null: false
      t.integer  "store_material_id"
      t.integer  "store_material_saleinfo_id"
      t.integer  "store_commission_template_id"
      t.string   "name",                         limit: 45,                  null: false
      t.integer  "mechanic_level",                           default: 1,     null: false
      t.integer  "work_time"
      t.string   "work_time_unit",               limit: 45
      t.integer  "work_time_in_seconds"
      t.boolean  "tracking_needed",                          default: false
      t.integer  "tracking_delay"
      t.string   "tracking_delay_unit",          limit: 10
      t.integer  "tracking_delay_in_seconds"
      t.integer  "tracking_contact_way"
      t.string   "tracking_content",             limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
