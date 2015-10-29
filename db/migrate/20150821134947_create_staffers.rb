
class CreateStaffers < ActiveRecord::Migration
  def change
    create_table "staffers", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "email",                  limit: 60
      t.string   "encrypted_password",     limit: 100
      t.string   "reset_password_token",   limit: 100
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count"
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip",     limit: 45
      t.string   "last_sign_in_ip",        limit: 45
      t.boolean  "deleted"
      t.boolean  "admin"
      t.integer  "role_id"
      t.string   "fullname",               limit: 45
     end
  end
end
