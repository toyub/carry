
class CreateStoreMaterialCategories < ActiveRecord::Migration
  def change
    create_table "store_material_categories", force: :cascade do |t|
      t.integer  "store_id",                              null: false
      t.integer  "store_chain_id",                        null: false
      t.integer  "store_staff_id",                        null: false
      t.integer  "parent_id",                 default: 0, null: false
      t.string   "name",           limit: 45
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
