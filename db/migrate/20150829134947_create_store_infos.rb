
class CreateStoreInfos < ActiveRecord::Migration
  def change
    create_table "store_infos", force: :cascade do |t|
      t.integer  "store_id",                     null: false
      t.integer  "store_chain_id"
      t.integer  "info_category_id",             null: false
      t.string   "value",            limit: 45
      t.string   "remark",           limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "state"
     end
  end
end
