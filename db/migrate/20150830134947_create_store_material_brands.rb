
class CreateStoreMaterialBrands < ActiveRecord::Migration
  def change
    create_table "store_material_brands", force: :cascade do |t|
      t.integer  "store_id"
      t.integer  "store_chain_id"
      t.integer  "store_staff_id"
      t.string   "name",           limit: 45
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
