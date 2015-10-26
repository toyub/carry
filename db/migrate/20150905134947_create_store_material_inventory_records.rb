
class CreateStoreMaterialInventoryRecords < ActiveRecord::Migration
  def change
    create_table "store_material_inventory_records", force: :cascade do |t|
      t.integer  "store_id",                                              null: false
      t.integer  "store_chain_id",                                        null: false
      t.integer  "store_staff_id",                                        null: false
      t.integer  "store_depot_id",                                        null: false
      t.integer  "store_material_id",                                     null: false
      t.integer  "store_material_order_id",                               null: false
      t.integer  "store_material_order_item_id",                          null: false
      t.integer  "store_material_inventory_id",                           null: false
      t.integer  "store_material_receipt_id",                             null: false
      t.integer  "quantity",                                              null: false
      t.integer  "prior_quantity"
      t.integer  "ordered_quantiry"
      t.decimal  "prior_cost_price",             precision: 10, scale: 2
      t.decimal  "ordered_cost_price",           precision: 10, scale: 2
      t.decimal  "latest_cost_price",            precision: 10, scale: 2
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
