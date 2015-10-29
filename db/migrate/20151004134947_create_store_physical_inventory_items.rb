
class CreateStorePhysicalInventoryItems < ActiveRecord::Migration
  def change
    create_table "store_physical_inventory_items", force: :cascade do |t|
      t.integer  "store_id",                                                                     null: false
      t.integer  "store_chain_id",                                                               null: false
      t.integer  "store_staff_id",                                                               null: false
      t.integer  "store_material_id",                                                            null: false
      t.integer  "store_depot_id",                                                               null: false
      t.integer  "store_inventory_id",                                                           null: false
      t.integer  "store_physical_inventory_id",                                                  null: false
      t.integer  "inventory",                                                                    null: false
      t.integer  "physical",                                                                     null: false
      t.integer  "diff",                                                                         null: false
      t.decimal  "inventory_cost_price",                    precision: 10, scale: 2
      t.decimal  "cost_price",                              precision: 10, scale: 2
      t.string   "remark",                      limit: 255
      t.integer  "status",                                                           default: 0
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
