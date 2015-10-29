
class CreateStoreVehicleBrands < ActiveRecord::Migration
  def change
    create_table "store_vehicle_brands", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "store_id",                  null: false
      t.integer  "store_chain_id",            null: false
      t.integer  "store_staff_id",            null: false
      t.string   "name",           limit: 45
     end
  end
end
