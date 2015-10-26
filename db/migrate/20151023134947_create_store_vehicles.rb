
class CreateStoreVehicles < ActiveRecord::Migration
  def change
    create_table "store_vehicles", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "store_id",                          null: false
      t.integer  "store_chain_id",                    null: false
      t.integer  "store_staff_id",                    null: false
      t.string   "model",                  limit: 45
      t.string   "series",                 limit: 45
      t.integer  "store_vehicle_brand_id"
      t.integer  "store_customer_id"
     end
  end
end
