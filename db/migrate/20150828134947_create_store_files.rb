
class CreateStoreFiles < ActiveRecord::Migration
  def change
    create_table "store_files", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "store_id",                   null: false
      t.integer  "store_chain_id",             null: false
      t.integer  "store_staff_id",             null: false
      t.string   "img",            limit: 255
      t.integer  "fileable_id",                null: false
      t.string   "fileable_type",  limit: 45,  null: false
      t.string   "type",           limit: 45
     end

     add_index "store_files", ["fileable_id", "fileable_type"], name: "fileable", using: :btree
     
  end
end
