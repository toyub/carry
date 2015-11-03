
class CreateStoreCommissionTemplates < ActiveRecord::Migration
  def change
    create_table "store_commission_templates", force: :cascade do |t|
      t.integer  "store_id",                                  null: false
      t.integer  "store_chain_id",                            null: false
      t.integer  "store_staff_id",                            null: false
      t.string   "name",              limit: 45
      t.integer  "aim_to"
      t.integer  "confined_to"
      t.integer  "mode_id"
      t.string   "level_weight_hash", limit: 100
      t.integer  "status",                        default: 0
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
