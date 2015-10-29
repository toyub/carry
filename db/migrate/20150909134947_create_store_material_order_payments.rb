
class CreateStoreMaterialOrderPayments < ActiveRecord::Migration
  def change
    create_table "store_material_order_payments", force: :cascade do |t|
      t.integer  "store_id",                                             null: false
      t.integer  "store_chain_id",                                       null: false
      t.integer  "store_staff_id",                                       null: false
      t.integer  "store_supplier_id",                                    null: false
      t.integer  "store_material_order_id",                              null: false
      t.integer  "store_settlement_account_id",                          null: false
      t.decimal  "amount",                      precision: 10, scale: 2
      t.decimal  "order_balance",               precision: 10, scale: 2
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
