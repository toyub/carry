
class CreateStoreMaterialOutings < ActiveRecord::Migration
  def change
    create_table "store_material_outings", force: :cascade do |t|
      t.integer  "store_id",                                            null: false
      t.integer  "store_chain_id",                                      null: false
      t.integer  "store_staff_id",                                      null: false
      t.integer  "requester_id"
      t.integer  "outing_type_id"
      t.string   "numero",         limit: 45
      t.integer  "total_quantity"
      t.decimal  "total_amount",               precision: 10, scale: 2
      t.string   "remark",         limit: 45
      t.string   "search_keys",    limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
