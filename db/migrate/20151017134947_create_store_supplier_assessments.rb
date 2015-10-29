
class CreateStoreSupplierAssessments < ActiveRecord::Migration
  def change
    create_table "store_supplier_assessments", force: :cascade do |t|
      t.integer  "store_id",                            null: false
      t.integer  "store_chain_id",                      null: false
      t.integer  "store_staff_id",                      null: false
      t.integer  "store_supplier_id"
      t.integer  "store_material_order_id"
      t.string   "remark",                  limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
