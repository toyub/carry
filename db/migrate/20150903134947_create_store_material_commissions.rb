
class CreateStoreMaterialCommissions < ActiveRecord::Migration
  def change
    create_table "store_material_commissions", force: :cascade do |t|
      t.string   "type",                         limit: 45
      t.integer  "store_id",                                null: false
      t.integer  "store_chain_id",                          null: false
      t.integer  "store_staff_id",                          null: false
      t.integer  "store_material_id"
      t.integer  "store_commission_template_id"
      t.datetime "created_at"
      t.datetime "updated_at"
     end

     add_index "store_material_commissions", ["type"], name: "type", using: :btree
     
  end
end
