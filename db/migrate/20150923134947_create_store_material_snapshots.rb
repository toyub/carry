
class CreateStoreMaterialSnapshots < ActiveRecord::Migration
  def change
    create_table "store_material_snapshots", force: :cascade do |t|
      t.integer  "store_id",                                                                            null: false
      t.integer  "store_chain_id",                                                                      null: false
      t.integer  "store_staff_id",                                                                      null: false
      t.integer  "store_material_root_category_id",                                                     null: false
      t.integer  "store_material_category_id",                                                          null: false
      t.integer  "store_material_unit_id",                                                              null: false
      t.integer  "store_material_manufacturer_id",                                                      null: false
      t.integer  "store_material_brand_id",                                                             null: false
      t.string   "name",                            limit: 45,                                          null: false
      t.string   "barcode",                         limit: 45
      t.string   "mnemonic",                        limit: 45
      t.string   "speci",                           limit: 45
      t.decimal  "cost_price",                                 precision: 10, scale: 2
      t.decimal  "min_price",                                  precision: 10, scale: 2
      t.boolean  "inventory_alarmify",                                                  default: false
      t.integer  "min_inventory"
      t.integer  "max_inventory"
      t.boolean  "expiry_alarmify",                                                     default: false
      t.integer  "shelf_life"
      t.boolean  "permitted_to_internal",                                               default: true,  null: false
      t.boolean  "permitted_to_saleable",                                               default: false, null: false
      t.text     "remark"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "store_material_id"
     end
  end
end
