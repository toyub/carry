
class CreateStoreChains < ActiveRecord::Migration
  def change
    create_table "store_chains", force: :cascade do |t|
      t.integer  "admin_store_id"
      t.integer  "admin_id"
      t.boolean  "chain_enabled",  default: false
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
