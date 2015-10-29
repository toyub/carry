
class CreateStoreMaterialInventories < ActiveRecord::Migration
  def change
    create_table "store_material_inventories", force: :cascade do |t|
      t.integer  "store_id",                                                 null: false
      t.integer  "store_chain_id",                                           null: false
      t.integer  "store_staff_id",                                           null: false
      t.integer  "store_material_id",                                        null: false
      t.integer  "store_depot_id",                                           null: false
      t.decimal  "cost_price",        precision: 10, scale: 2, default: 0.0
      t.integer  "quantity",                                   default: 0,   null: false
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
