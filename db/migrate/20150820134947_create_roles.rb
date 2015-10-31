
class CreateRoles < ActiveRecord::Migration
  def change
    create_table "roles", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "name",           limit: 45,              null: false
      t.string   "abbrev",         limit: 45,              null: false
      t.integer  "position"
      t.string   "description",    limit: 255
      t.integer  "staffers_count",             default: 0
     end

     add_index "roles", ["abbrev"], name: "abbrev_UNIQUE", unique: true, using: :btree
     add_index "roles", ["name"], name: "name_UNIQUE", unique: true, using: :btree
     
  end
end
