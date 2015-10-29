
class CreateStoreMaterialTransReceiptItems < ActiveRecord::Migration
  def change
    create_table "store_material_trans_receipt_items", force: :cascade do |t|
      t.integer  "store_id",                                                            null: false
      t.integer  "store_chain_id",                                                      null: false
      t.integer  "store_staff_id",                                                      null: false
      t.integer  "store_depot_id",                                                      null: false
      t.integer  "store_material_id",                                                   null: false
      t.integer  "store_material_picking_id",                                           null: false
      t.integer  "store_material_picking_item_id",                                      null: false
      t.integer  "store_material_inventory_id",                                         null: false
      t.integer  "store_material_receipt_id",                                           null: false
      t.integer  "quantity",                                                            null: false
      t.integer  "prior_quantity"
      t.integer  "ordered_quantity"
      t.decimal  "prior_cost_price",                           precision: 10, scale: 2
      t.decimal  "ordered_cost_price",                         precision: 10, scale: 2
      t.decimal  "inventory_cost_price",                       precision: 10, scale: 2
      t.decimal  "latest_cost_price",                          precision: 10, scale: 2
      t.string   "remark",                         limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
