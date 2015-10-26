
class CreateStoreMaterialShrinkages < ActiveRecord::Migration
  def change
    create_table "store_material_shrinkages", force: :cascade do |t|
      t.integer  "store_id",                                                          null: false
      t.integer  "store_chain_id",                                                    null: false
      t.integer  "store_staff_id",                                                    null: false
      t.string   "numero",         limit: 45
      t.integer  "total_quantity",                                      default: 0
      t.decimal  "total_amount",               precision: 10, scale: 2, default: 0.0
      t.string   "remark",         limit: 255
      t.string   "search_keys",    limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
