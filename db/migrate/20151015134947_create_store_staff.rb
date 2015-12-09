
class CreateStoreStaff < ActiveRecord::Migration
  def change
    create_table "store_staff", force: :cascade do |t|
      t.integer  "store_id"
      t.integer  "store_chain_id"
      t.string   "login_name",         limit: 45,                          null: false
      t.string   "gender",             limit: 6,  default: "male",         null: false
      t.string   "first_name",         limit: 45
      t.string   "last_name",          limit: 45
      t.string   "name_display_type",  limit: 13, default: "lastname_pre", null: false
      t.text     "encrypted_password",                                     null: false
      t.text     "salt",                                                   null: false
      t.integer  "work_status",                   default: 0,              null: false
      t.datetime "created_at"
      t.datetime "updated_at"
     end

     add_index "store_staff", ["login_name", "work_status"], name: "login_name_work_status_index", using: :btree

  end
end
