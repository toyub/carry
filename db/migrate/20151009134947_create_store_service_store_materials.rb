
class CreateStoreServiceStoreMaterials < ActiveRecord::Migration
  def change
    create_table "store_service_store_materials", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "store_id",          null: false
      t.integer  "store_chain_id",    null: false
      t.integer  "store_staff_id"
      t.integer  "store_service_id",  null: false
      t.integer  "store_material_id", null: false
     end
  end
end
