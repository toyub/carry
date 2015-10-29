
class CreateRenewalRecords < ActiveRecord::Migration
  def change
    create_table "renewal_records", force: :cascade do |t|
      t.datetime "pay_date",                                            null: false
      t.integer  "renewal_days",                                        null: false
      t.decimal  "renewal_money",              precision: 10, scale: 2, null: false
      t.string   "pay_party",      limit: 255,                          null: false
      t.string   "settlement_way", limit: 6,                            null: false
      t.string   "invoice_type",   limit: 4,                            null: false
      t.boolean  "receipt_type",                                        null: false
      t.integer  "store_id",                                            null: false
      t.integer  "store_chain_id",                                      null: false
     end
  end
end
