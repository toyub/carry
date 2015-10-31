
class CreateStoreMaterialReturnings < ActiveRecord::Migration
  def change
    create_table "store_material_returnings", force: :cascade do |t|
      t.integer  "store_id",                                                            null: false
      t.integer  "store_chain_id",                                                      null: false
      t.integer  "store_staff_id",                                                      null: false
      t.integer  "store_supplier_id",                                                   null: false
      t.string   "numero",            limit: 45,                                        null: false
      t.integer  "total_quantity"
      t.decimal  "total_amount",                  precision: 10, scale: 2
      t.string   "remark",            limit: 255
      t.string   "search_keys",       limit: 255,                          default: ""
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
