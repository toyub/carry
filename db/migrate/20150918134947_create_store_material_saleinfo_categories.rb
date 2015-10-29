
class CreateStoreMaterialSaleinfoCategories < ActiveRecord::Migration
  def change
    create_table "store_material_saleinfo_categories", force: :cascade do |t|
      t.integer  "store_id",                              null: false
      t.integer  "store_chain_id",                        null: false
      t.integer  "store_staff_id",                        null: false
      t.integer  "store_material_category_id"
      t.string   "name",                       limit: 45, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
