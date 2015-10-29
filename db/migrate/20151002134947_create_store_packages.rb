
class CreateStorePackages < ActiveRecord::Migration
  def change
    create_table "store_packages", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "store_id",                   null: false
      t.integer  "store_chain_id",             null: false
      t.integer  "store_staff_id",             null: false
      t.string   "name",           limit: 45
      t.string   "code",           limit: 45
      t.string   "abstract",       limit: 255
      t.text     "remark"
     end
  end
end
