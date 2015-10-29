
class CreateStoreMaterialReturningItems < ActiveRecord::Migration
  def change
    create_table "store_material_returning_items", force: :cascade do |t|
      t.integer  "store_id",                                                         null: false
      t.integer  "store_chain_id",                                                   null: false
      t.integer  "store_staff_id",                                                   null: false
      t.integer  "store_supplier_id",                                                null: false
      t.integer  "store_material_id",                                                null: false
      t.integer  "store_material_inventory_id",                                      null: false
      t.integer  "store_depot_id",                                                   null: false
      t.integer  "store_material_returning_id",                                      null: false
      t.integer  "quantity",                                                         null: false
      t.decimal  "price",                                   precision: 10, scale: 2, null: false
      t.integer  "prior_quantity",                                                   null: false
      t.string   "remark",                      limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
