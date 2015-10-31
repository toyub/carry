
class CreateStoreSettlementAccounts < ActiveRecord::Migration
  def change
    create_table "store_settlement_accounts", force: :cascade do |t|
      t.integer  "store_id",                                 null: false
      t.integer  "store_chain_id",                           null: false
      t.integer  "store_staff_id",                           null: false
      t.string   "name",             limit: 45
      t.string   "bank_name",        limit: 200
      t.string   "bank_card_number", limit: 100
      t.integer  "status",                       default: 0, null: false
      t.string   "remark",           limit: 255
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
