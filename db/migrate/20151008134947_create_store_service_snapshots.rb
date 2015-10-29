
class CreateStoreServiceSnapshots < ActiveRecord::Migration
  def change
    create_table "store_service_snapshots", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "store_staff_id",                                                                null: false
      t.integer  "store_chain_id",                                                                null: false
      t.integer  "store_id",                                                                      null: false
      t.string   "name",                      limit: 45
      t.string   "code",                      limit: 45
      t.integer  "standard_time"
      t.integer  "store_service_unit_id"
      t.decimal  "retail_price",                         precision: 10, scale: 2, default: 0.0
      t.decimal  "bargain_price",                        precision: 10, scale: 2, default: 0.0
      t.integer  "point"
      t.text     "introduction"
      t.text     "remark"
      t.integer  "store_service_category_id"
      t.integer  "buffering_time"
      t.integer  "factor_time"
      t.integer  "engineer_count"
      t.integer  "engineer_level"
      t.integer  "position_mode"
      t.boolean  "favorable",                                                     default: false
      t.integer  "setting_type",                                                  default: 0
      t.integer  "store_service_id"
     end

     add_index "store_service_snapshots", ["store_service_category_id"], name: "store_service_snapshots_store_service_category_id", using: :btree
     
  end
end
