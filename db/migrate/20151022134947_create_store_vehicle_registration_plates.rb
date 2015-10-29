
class CreateStoreVehicleRegistrationPlates < ActiveRecord::Migration
  def change
    create_table "store_vehicle_registration_plates", force: :cascade do |t|
      t.integer  "store_id",                     null: false
      t.integer  "store_chain_id",               null: false
      t.integer  "store_staff_id",               null: false
      t.integer  "store_customer_id",            null: false
      t.string   "license_number",    limit: 45, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "store_vehicle_id"
     end
  end
end
