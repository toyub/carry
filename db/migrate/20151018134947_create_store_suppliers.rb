
class CreateStoreSuppliers < ActiveRecord::Migration
  def change
    create_table "store_suppliers", force: :cascade do |t|
      t.integer  "store_id",                                                   null: false
      t.integer  "store_chain_id",                                             null: false
      t.integer  "store_staff_id",                                             null: false
      t.integer  "store_material_root_category_id"
      t.integer  "store_material_category_id"
      t.string   "numero",                          limit: 45
      t.string   "name",                            limit: 45,                 null: false
      t.string   "mnemonic",                        limit: 45
      t.string   "contact_name",                    limit: 45
      t.string   "contact_phone_number",            limit: 45
      t.string   "contact_tel_number",              limit: 45
      t.string   "contact_fax_number",              limit: 45
      t.string   "contact_email",                   limit: 45
      t.string   "location_country_code",           limit: 45
      t.string   "location_state_code",             limit: 45
      t.string   "location_city_code",              limit: 45
      t.string   "location_address",                limit: 45
      t.integer  "info_source_id"
      t.integer  "weight_id"
      t.integer  "clearing_mode_id"
      t.integer  "clearing_cycle_id"
      t.string   "clearing_day",                    limit: 45
      t.string   "clearing_bank",                   limit: 45
      t.string   "clearing_account",                limit: 45
      t.string   "clearing_vatin",                  limit: 45
      t.boolean  "clearing_alarmify",                          default: false
      t.integer  "clearing_payment_method_id"
      t.string   "remark",                          limit: 45
      t.integer  "status",                                     default: 0
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
