
class CreateStoreMaterialOrders < ActiveRecord::Migration
  def change
    create_table "store_material_orders", force: :cascade do |t|
      t.integer  "store_id",                                                             null: false
      t.integer  "store_chain_id",                                                       null: false
      t.integer  "store_staff_id",                                                       null: false
      t.integer  "store_supplier_id",                                                    null: false
      t.string   "numero",            limit: 45
      t.decimal  "amount",                        precision: 12, scale: 4, default: 0.0
      t.integer  "quantity",                                               default: 0
      t.decimal  "paid_amount",                   precision: 10, scale: 2, default: 0.0
      t.integer  "process",                                                default: 0,   null: false
      t.string   "remark",            limit: 255
      t.integer  "status",                                                 default: 0
      t.integer  "paid_status",                                            default: 0
      t.integer  "received_status",                                        default: 0
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
