
class CreateCaStations < ActiveRecord::Migration
  def change
    create_table "ca_stations", force: :cascade do |t|
      t.integer  "store_id",                  null: false
      t.integer  "store_chain_id",            null: false
      t.string   "name",           limit: 45
      t.integer  "quantity"
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
