
class CreateStoreMaterialReceipts < ActiveRecord::Migration
  def change
    create_table "store_material_receipts", force: :cascade do |t|
      t.integer  "store_id",                   null: false
      t.integer  "store_chain_id",             null: false
      t.integer  "store_staff_id",             null: false
      t.string   "numero",         limit: 45
      t.string   "remark",         limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
