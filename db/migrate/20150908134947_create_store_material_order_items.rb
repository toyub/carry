
class CreateStoreMaterialOrderItems < ActiveRecord::Migration
  def change
    create_table "store_material_order_items", force: :cascade do |t|
      t.integer  "store_id",                                                                 null: false
      t.integer  "store_chain_id",                                                           null: false
      t.integer  "store_staff_id",                                                           null: false
      t.integer  "store_material_id",                                                        null: false
      t.integer  "store_supplier_id",                                                        null: false
      t.integer  "store_material_order_id",                                                  null: false
      t.decimal  "price",                               precision: 10, scale: 2,             null: false
      t.integer  "quantity",                                                                 null: false
      t.integer  "received_quantity",                                            default: 0, null: false
      t.integer  "returned_quantity",                                            default: 0, null: false
      t.integer  "process",                                                      default: 0, null: false
      t.decimal  "amount",                              precision: 12, scale: 4
      t.string   "remark",                  limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
