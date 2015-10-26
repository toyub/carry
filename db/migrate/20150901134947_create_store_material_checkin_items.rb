
class CreateStoreMaterialCheckinItems < ActiveRecord::Migration
  def change
    create_table "store_material_checkin_items", force: :cascade do |t|
      t.integer  "store_id",                                                         null: false
      t.integer  "store_chain_id",                                                   null: false
      t.integer  "store_staff_id",                                                   null: false
      t.integer  "store_depot_id",                                                   null: false
      t.integer  "store_material_id",                                                null: false
      t.integer  "store_material_inventory_id",                                      null: false
      t.integer  "store_material_checkin_id",                                        null: false
      t.integer  "quantity",                                                         null: false
      t.integer  "prior_quantity"
      t.decimal  "price",                                   precision: 10, scale: 2
      t.decimal  "amount",                                  precision: 10, scale: 2
      t.decimal  "prior_cost_price",                        precision: 10, scale: 2
      t.decimal  "latest_cost_price",                       precision: 10, scale: 2
      t.string   "remark",                      limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
