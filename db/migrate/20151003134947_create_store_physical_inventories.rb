
class CreateStorePhysicalInventories < ActiveRecord::Migration
  def change
    create_table "store_physical_inventories", force: :cascade do |t|
      t.integer  "store_id",                              null: false
      t.integer  "store_chain_id",                        null: false
      t.integer  "store_staff_id",                        null: false
      t.integer  "store_depot_id",                        null: false
      t.integer  "status",                    default: 0
      t.string   "created_month",  limit: 20
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
