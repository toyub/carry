# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160408073906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agent_payments", force: :cascade do |t|
    t.integer  "agent_id"
    t.integer  "quantity"
    t.decimal  "amount"
    t.integer  "creator_id"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agents", force: :cascade do |t|
    t.integer  "staffer_id"
    t.integer  "quota"
    t.decimal  "balance"
    t.string   "charge_area"
    t.string   "company_name"
    t.string   "company_address"
    t.string   "phone_number"
    t.string   "cooperation_way"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
  end

  create_table "api_tokens", force: :cascade do |t|
    t.string   "sn_code"
    t.string   "token"
    t.integer  "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ca_stations", force: :cascade do |t|
    t.integer  "store_id",                  null: false
    t.integer  "store_chain_id",            null: false
    t.string   "name",           limit: 45
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "captchas", force: :cascade do |t|
    t.string   "phone"
    t.string   "token"
    t.datetime "sent_at"
    t.boolean  "verification_used", default: false
    t.integer  "switch_type_id",    default: 1
    t.string   "verification"
    t.boolean  "token_available",   default: true
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "complaints", force: :cascade do |t|
    t.integer  "store_customer_id"
    t.integer  "store_vehicle_id"
    t.integer  "store_order_id"
    t.integer  "updator_id"
    t.json     "detail"
    t.integer  "satisfaction"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "store_id"
    t.integer  "store_chain_id"
  end

  create_table "credits", force: :cascade do |t|
    t.decimal  "amount",     precision: 14, scale: 4
    t.string   "subject"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "party_type"
    t.integer  "party_id"
  end

  create_table "debits", force: :cascade do |t|
    t.decimal  "amount",     precision: 14, scale: 4
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "party_type"
    t.integer  "party_id"
    t.integer  "payment_id"
  end

  create_table "info_categories", force: :cascade do |t|
    t.string   "name",       limit: 45, null: false
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "journal_entries", force: :cascade do |t|
    t.string   "party_type"
    t.integer  "party_id"
    t.decimal  "balance",          precision: 14, scale: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "journalable_type"
    t.integer  "journalable_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "orderable_type"
    t.integer  "orderable_id"
    t.integer  "quantity",                                null: false
    t.decimal  "price",          precision: 12, scale: 2, null: false
    t.decimal  "amount",         precision: 14, scale: 4, null: false, comment: "amount = price * quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "party_type"
    t.integer  "party_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "numero"
    t.string   "party_type"
    t.integer  "party_id"
    t.string   "subject"
    t.decimal  "amount",     precision: 14, scale: 4,                 comment: "amount = sum(order_items.amount)"
    t.integer  "staffer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid",                                default: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "staffer_id"
    t.integer  "order_id"
    t.string   "party_type"
    t.integer  "party_id"
    t.decimal  "amount",              precision: 14, scale: 4
    t.string   "payment_method_type"
    t.json     "third_party_params"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "debit_id"
    t.string   "subject"
  end

  create_table "recommended_order_items", force: :cascade do |t|
    t.integer  "recommended_order_id"
    t.integer  "quantity"
    t.decimal  "price"
    t.decimal  "amount"
    t.integer  "itemable_id"
    t.string   "itemable_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.decimal  "retail_price"
    t.integer  "store_staff_id"
    t.integer  "store_id"
    t.integer  "store_chain_id"
  end

  create_table "recommended_orders", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.decimal  "amount"
    t.text     "remark"
    t.integer  "store_customer_id"
    t.integer  "store_vehicle_id"
    t.integer  "state"
    t.string   "numero"
    t.string   "recommended_reason"
    t.string   "refuse_reason"
    t.datetime "recommended_date"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "renewal_records", force: :cascade do |t|
    t.datetime "pay_date",                                            null: false
    t.integer  "renewal_days",                                        null: false
    t.decimal  "renewal_money",              precision: 12, scale: 2, null: false
    t.string   "pay_party",      limit: 255,                          null: false
    t.string   "settlement_way", limit: 6,                            null: false
    t.string   "invoice_type",   limit: 4,                            null: false
    t.boolean  "receipt_type",                                        null: false
    t.integer  "store_id",                                            null: false
    t.integer  "store_chain_id",                                      null: false
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",           limit: 45,              null: false
    t.string   "abbrev",         limit: 45,              null: false
    t.integer  "position"
    t.string   "description",    limit: 255
    t.integer  "staffers_count",             default: 0
  end

  add_index "roles", ["abbrev"], name: "abbrev_UNIQUE", unique: true, using: :btree
  add_index "roles", ["name"], name: "name_UNIQUE", unique: true, using: :btree

  create_table "sms_balances", force: :cascade do |t|
    t.string   "party_type"
    t.integer  "party_id"
    t.integer  "total",         default: 0
    t.decimal  "total_fee",     default: 0.0
    t.integer  "sent_quantity", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sms_records", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "receiver_name"
    t.integer  "receiver_id"
    t.string   "first_category"
    t.integer  "second_category"
    t.text     "content"
    t.integer  "quantity",        default: 1
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "store_id"
    t.string   "party_type"
    t.integer  "party_id"
    t.string   "receiver_type"
  end

  create_table "staffer_operation_logs", force: :cascade do |t|
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "staffer_id"
    t.json     "log"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffers", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 60
    t.string   "encrypted_password",     limit: 100
    t.string   "reset_password_token",   limit: 100
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 45
    t.string   "last_sign_in_ip",        limit: 45
    t.boolean  "deleted"
    t.boolean  "admin"
    t.integer  "role_id"
    t.string   "fullname",               limit: 45
    t.string   "family_name"
    t.string   "name"
    t.string   "login_name"
  end

  create_table "store_attachments", force: :cascade do |t|
    t.string   "type",         limit: 45, null: false
    t.integer  "host_id",                 null: false
    t.string   "file_name",    limit: 45, null: false
    t.integer  "file_size",               null: false
    t.string   "content_type", limit: 45, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_attachments", ["type", "host_id"], name: "type_of_attachments", using: :btree

  create_table "store_business_status_records", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "staffer_id"
    t.string   "reason"
    t.integer  "previous_status"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_chains", force: :cascade do |t|
    t.integer  "admin_store_id"
    t.integer  "admin_id"
    t.boolean  "chain_enabled",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
  end

  create_table "store_commission_items", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.integer  "store_order_id"
    t.string   "store_order_numero"
    t.integer  "store_order_item_id"
    t.string   "store_order_item_name"
    t.string   "store_order_item_remark"
    t.decimal  "item_amount",             precision: 8, scale: 2
    t.decimal  "commission_amount",       precision: 8, scale: 2
    t.string   "commission_type"
    t.datetime "order_created_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "orderable_type"
    t.string   "ownerable_type"
    t.integer  "ownerable_id"
    t.integer  "store_commission_id"
  end

  create_table "store_commission_template_sections", force: :cascade do |t|
    t.integer  "store_id",                                              null: false
    t.integer  "store_chain_id",                                        null: false
    t.integer  "store_staff_id",                                        null: false
    t.integer  "store_commission_template_id",                          null: false
    t.integer  "mode_id"
    t.integer  "type_id"
    t.integer  "source_id"
    t.decimal  "min",                          precision: 10, scale: 2
    t.decimal  "max",                          precision: 10, scale: 2
    t.decimal  "amount",                       precision: 8,  scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_commission_templates", force: :cascade do |t|
    t.integer  "store_id",                                     null: false
    t.integer  "store_chain_id",                               null: false
    t.integer  "store_staff_id",                               null: false
    t.string   "name",              limit: 45
    t.integer  "aim_to"
    t.integer  "confined_to"
    t.integer  "mode_id"
    t.json     "level_weight_hash",            default: {}
    t.integer  "status",                       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sharing_enabled",              default: false
  end

  create_table "store_commissions", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.string   "created_month"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "ownerable_type"
    t.integer  "ownerable_id"
  end

  create_table "store_customer_asset_items", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_customer_id"
    t.string   "assetable_type"
    t.integer  "assetable_id"
    t.integer  "total_quantity",          default: 0
    t.integer  "used_quantity",           default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "store_customer_asset_id"
    t.json     "workflowable_hash",       default: {}
    t.integer  "package_item_id"
    t.string   "package_item_type"
  end

  create_table "store_customer_asset_logs", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_customer_id"
    t.integer  "store_vehicle_id"
    t.integer  "store_order_id"
    t.integer  "store_order_item_id"
    t.integer  "store_customer_asset_item_id"
    t.integer  "latest",                       default: 0
    t.integer  "quantity",                     default: 0
    t.integer  "balance",                      default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "store_customer_assets", force: :cascade do |t|
    t.string   "type"
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_customer_id"
    t.integer  "store_vehicle_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "package_type"
    t.integer  "package_id"
    t.string   "package_name"
  end

  create_table "store_customer_categories", force: :cascade do |t|
    t.integer  "store_id",                              null: false
    t.integer  "store_chain_id",                        null: false
    t.integer  "store_staff_id",                        null: false
    t.string   "name",                                  null: false
    t.string   "description"
    t.string   "color"
    t.boolean  "auto_promoted_enabled", default: false
    t.json     "conditions"
    t.json     "discounts"
    t.json     "privileges"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_customer_deposit_logs", force: :cascade do |t|
    t.string   "type"
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_customer_id"
    t.integer  "store_vehicle_id"
    t.integer  "store_order_id"
    t.string   "subject"
    t.decimal  "latest",            precision: 12, scale: 2, default: 0.0
    t.decimal  "amount",            precision: 14, scale: 4, default: 0.0
    t.decimal  "balance",           precision: 14, scale: 4, default: 0.0
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "store_customer_entities", force: :cascade do |t|
    t.integer  "store_customer_category_id"
    t.string   "telephone"
    t.string   "mobile"
    t.string   "qq"
    t.json     "district"
    t.string   "address"
    t.float    "range"
    t.integer  "property",                   default: 0
    t.string   "remark"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "store_id"
    t.integer  "store_staff_id"
    t.integer  "store_chain_id"
    t.decimal  "balance",                    default: 0.0,   null: false
    t.integer  "points"
    t.boolean  "membership",                 default: false
  end

  create_table "store_customer_payments", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_customer_id"
    t.integer  "store_customer_debit_id"
    t.string   "payment_method_type"
    t.string   "subject"
    t.decimal  "amount",                  precision: 14, scale: 4, default: 0.0
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.integer  "store_order_id"
    t.integer  "store_staff_id"
  end

  create_table "store_customer_settlements", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.string   "bank"
    t.string   "bank_account"
    t.string   "contract"
    t.string   "tax"
    t.string   "invoice_title"
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.integer  "store_customer_entity_id"
    t.decimal  "credit_bill_amount",       precision: 12, scale: 2, default: 0.0, null: false
    t.decimal  "credit_limit",             precision: 12, scale: 2, default: 0.0, null: false
    t.integer  "credit",                                            default: 0
    t.integer  "notice_period",                                     default: 0
    t.integer  "payment_mode",                                      default: 0
    t.integer  "invoice_type",                                      default: 0
    t.string   "contact"
  end

  create_table "store_customers", force: :cascade do |t|
    t.integer  "store_id",                                          null: false
    t.integer  "store_chain_id",                                    null: false
    t.integer  "store_staff_id",                                    null: false
    t.string   "first_name",                 limit: 45,             null: false
    t.string   "last_name",                  limit: 45,             null: false
    t.string   "full_name",                  limit: 45,             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number",               limit: 45
    t.string   "qq"
    t.integer  "store_customer_category_id"
    t.boolean  "gender"
    t.string   "nick"
    t.string   "resident_id"
    t.date     "birthday"
    t.boolean  "married"
    t.string   "company"
    t.boolean  "tracking_accepted"
    t.boolean  "message_accepted"
    t.integer  "store_customer_entity_id"
    t.string   "telephone"
    t.string   "remark"
    t.integer  "education",                             default: 0
    t.integer  "profession",                            default: 0
    t.integer  "income",                                default: 0
    t.integer  "points"
  end

  create_table "store_departments", force: :cascade do |t|
    t.integer "store_id"
    t.integer "store_chain_id"
    t.integer "store_staff_id"
    t.integer "parent_id",      default: 0
    t.string  "name"
  end

  create_table "store_deposit_cards", force: :cascade do |t|
    t.decimal  "price",          precision: 12, scale: 2, default: 0.0
    t.decimal  "denomination",   precision: 12, scale: 2, default: 0.0
    t.string   "name"
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  create_table "store_depots", force: :cascade do |t|
    t.integer  "store_id",                                  null: false
    t.integer  "store_chain_id",                            null: false
    t.integer  "store_staff_id",                            null: false
    t.string   "name",           limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",                   default: false
    t.boolean  "preferred",                 default: false
    t.boolean  "useable",                   default: true
    t.integer  "admin_ids",                                              array: true
    t.string   "description"
  end

  create_table "store_employees", force: :cascade do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "gender",                   limit: 6,   default: "male", null: false
    t.datetime "birthday"
    t.string   "education"
    t.string   "polity"
    t.string   "native_place"
    t.string   "census_register"
    t.string   "identity_card"
    t.string   "marital_status"
    t.string   "height"
    t.string   "weight"
    t.string   "phone_number",                                          null: false
    t.string   "mailbox"
    t.string   "address"
    t.string   "census_register_address"
    t.string   "contact_one"
    t.string   "contact_one_phone_number"
    t.string   "contact_two"
    t.string   "contact_two_phone_number"
    t.string   "remark",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_envelopes", force: :cascade do |t|
    t.integer  "store_message_id"
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.string   "receiver_type"
    t.integer  "receiver_id"
    t.boolean  "opened",           default: false
    t.boolean  "deleted",          default: false
    t.datetime "created_at"
    t.datetime "update_at"
  end

  create_table "store_events", force: :cascade do |t|
    t.integer  "store_staff_id"
    t.string   "type"
    t.string   "sort"
    t.text     "description"
    t.json     "operate",        default: {}
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.datetime "occur_on"
    t.datetime "start_on"
    t.datetime "end_on"
    t.string   "occur_at"
    t.integer  "recorder_id"
    t.integer  "period"
    t.string   "created_month",  default: "201512"
  end

  create_table "store_files", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                   null: false
    t.integer  "store_chain_id",             null: false
    t.integer  "store_staff_id",             null: false
    t.string   "img",            limit: 255
    t.integer  "fileable_id",                null: false
    t.string   "fileable_type",  limit: 45,  null: false
  end

  add_index "store_files", ["fileable_id", "fileable_type"], name: "fileable", using: :btree

  create_table "store_group_members", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.integer  "store_group_id"
    t.integer  "member_id"
    t.integer  "work_status",    default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "store_groups", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.string   "name"
    t.boolean  "deleted",        default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "store_infos", force: :cascade do |t|
    t.integer  "store_id",                                    null: false
    t.integer  "store_chain_id"
    t.integer  "info_category_id",                            null: false
    t.string   "value",            limit: 45
    t.string   "remark",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "using",                        default: true
  end

  create_table "store_material_brands", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.string   "name",           limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_categories", force: :cascade do |t|
    t.integer  "store_id",                              null: false
    t.integer  "store_chain_id",                        null: false
    t.integer  "store_staff_id",                        null: false
    t.integer  "parent_id",                 default: 0, null: false
    t.string   "name",           limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_checkin_items", force: :cascade do |t|
    t.integer  "store_id",                                                         null: false
    t.integer  "store_chain_id",                                                   null: false
    t.integer  "store_staff_id",                                                   null: false
    t.integer  "store_depot_id",                                                   null: false
    t.integer  "store_material_id",                                                null: false
    t.integer  "store_material_inventory_id",                                      null: false
    t.integer  "store_material_checkin_id",                                        null: false
    t.integer  "quantity",                                                         null: false
    t.integer  "prior_quantity"
    t.decimal  "price",                                   precision: 12, scale: 2
    t.decimal  "amount",                                  precision: 14, scale: 4
    t.decimal  "prior_cost_price",                        precision: 12, scale: 2
    t.decimal  "latest_cost_price",                       precision: 12, scale: 2
    t.string   "remark",                      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_checkins", force: :cascade do |t|
    t.integer  "store_id",                                                          null: false
    t.integer  "store_chain_id",                                                    null: false
    t.integer  "store_staff_id",                                                    null: false
    t.integer  "store_depot_id"
    t.string   "numero",         limit: 45
    t.integer  "quantity",                                            default: 0
    t.decimal  "amount",                     precision: 14, scale: 4, default: 0.0
    t.string   "remark",         limit: 255
    t.string   "search_keys",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_commissions", force: :cascade do |t|
    t.string   "type",                         limit: 45
    t.integer  "store_id",                                null: false
    t.integer  "store_chain_id",                          null: false
    t.integer  "store_staff_id",                          null: false
    t.integer  "store_material_id"
    t.integer  "store_commission_template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_material_commissions", ["type"], name: "type", using: :btree

  create_table "store_material_inventories", force: :cascade do |t|
    t.integer  "store_id",                                                 null: false
    t.integer  "store_chain_id",                                           null: false
    t.integer  "store_staff_id",                                           null: false
    t.integer  "store_material_id",                                        null: false
    t.integer  "store_depot_id",                                           null: false
    t.decimal  "cost_price",        precision: 12, scale: 2, default: 0.0
    t.integer  "quantity",                                   default: 0,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_inventory_records", force: :cascade do |t|
    t.integer  "store_id",                                              null: false
    t.integer  "store_chain_id",                                        null: false
    t.integer  "store_staff_id",                                        null: false
    t.integer  "store_depot_id",                                        null: false
    t.integer  "store_material_id",                                     null: false
    t.integer  "store_material_order_id",                               null: false
    t.integer  "store_material_order_item_id",                          null: false
    t.integer  "store_material_inventory_id",                           null: false
    t.integer  "store_material_receipt_id",                             null: false
    t.integer  "quantity",                                              null: false
    t.integer  "prior_quantity"
    t.integer  "ordered_quantiry"
    t.decimal  "prior_cost_price",             precision: 12, scale: 2
    t.decimal  "ordered_cost_price",           precision: 12, scale: 2
    t.decimal  "latest_cost_price",            precision: 12, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remark"
  end

  create_table "store_material_logs", force: :cascade do |t|
    t.integer  "store_id",                                            null: false
    t.integer  "store_chain_id",                                      null: false
    t.integer  "store_staff_id",                                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "logged_item_type"
    t.integer  "logged_item_id"
    t.integer  "store_depot_id"
    t.integer  "store_material_id"
    t.integer  "store_material_inventory_id"
    t.json     "openings",                               default: {}
    t.json     "closings",                               default: {}
    t.json     "accruals",                               default: {}
    t.string   "created_month",               limit: 20
  end

  create_table "store_material_manufacturers", force: :cascade do |t|
    t.integer  "store_id",                  null: false
    t.integer  "store_chain_id",            null: false
    t.integer  "store_staff_id",            null: false
    t.string   "name",           limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_order_items", force: :cascade do |t|
    t.integer  "store_id",                                                                 null: false
    t.integer  "store_chain_id",                                                           null: false
    t.integer  "store_staff_id",                                                           null: false
    t.integer  "store_material_id",                                                        null: false
    t.integer  "store_supplier_id",                                                        null: false
    t.integer  "store_material_order_id",                                                  null: false
    t.decimal  "price",                               precision: 12, scale: 2,             null: false
    t.integer  "quantity",                                                                 null: false
    t.integer  "received_quantity",                                            default: 0, null: false
    t.integer  "returned_quantity",                                            default: 0, null: false
    t.integer  "process",                                                      default: 0, null: false
    t.decimal  "amount",                              precision: 14, scale: 4
    t.string   "remark",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_order_payments", force: :cascade do |t|
    t.integer  "store_id",                                             null: false
    t.integer  "store_chain_id",                                       null: false
    t.integer  "store_staff_id",                                       null: false
    t.integer  "store_supplier_id",                                    null: false
    t.integer  "store_material_order_id",                              null: false
    t.integer  "store_settlement_account_id",                          null: false
    t.decimal  "amount",                      precision: 14, scale: 4
    t.decimal  "order_balance",               precision: 14, scale: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_orders", force: :cascade do |t|
    t.integer  "store_id",                                                             null: false
    t.integer  "store_chain_id",                                                       null: false
    t.integer  "store_staff_id",                                                       null: false
    t.integer  "store_supplier_id",                                                    null: false
    t.string   "numero",            limit: 45
    t.decimal  "amount",                        precision: 14, scale: 4, default: 0.0
    t.integer  "quantity",                                               default: 0
    t.decimal  "paid_amount",                   precision: 14, scale: 4, default: 0.0
    t.integer  "process",                                                default: 0,   null: false
    t.string   "remark",            limit: 255
    t.integer  "status",                                                 default: 0
    t.integer  "paid_status",                                            default: 0
    t.integer  "received_status",                                        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "withdrawal_by"
    t.datetime "withdrawal_at"
  end

  create_table "store_material_outing_items", force: :cascade do |t|
    t.integer  "outing_type_id"
    t.integer  "store_id",                                                         null: false
    t.integer  "store_chain_id",                                                   null: false
    t.integer  "store_staff_id",                                                   null: false
    t.integer  "store_material_outing_id",                                         null: false
    t.integer  "requester_id"
    t.integer  "store_material_id",                                                null: false
    t.integer  "store_material_inventory_id",                                      null: false
    t.integer  "store_depot_id",                                                   null: false
    t.integer  "quantity"
    t.decimal  "amount",                                  precision: 14, scale: 4
    t.decimal  "cost_price",                              precision: 12, scale: 2
    t.decimal  "inventory_cost_price",                    precision: 12, scale: 2
    t.string   "remark",                      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_outings", force: :cascade do |t|
    t.integer  "store_id",                                             null: false
    t.integer  "store_chain_id",                                       null: false
    t.integer  "store_staff_id",                                       null: false
    t.integer  "requester_id"
    t.integer  "outing_type_id"
    t.string   "numero",          limit: 45
    t.integer  "total_quantity"
    t.decimal  "total_amount",                precision: 14, scale: 4
    t.string   "remark",          limit: 45
    t.string   "search_keys",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "outingable_type"
    t.integer  "outingable_id"
  end

  create_table "store_material_picking_items", force: :cascade do |t|
    t.integer  "store_id",                                                                       null: false
    t.integer  "store_chain_id",                                                                 null: false
    t.integer  "store_staff_id",                                                                 null: false
    t.integer  "store_depot_id",                                                                 null: false
    t.integer  "dest_depot_id",                                                                  null: false
    t.integer  "store_material_id",                                                              null: false
    t.integer  "store_material_inventory_id",                                                    null: false
    t.integer  "store_material_picking_id",                                                      null: false
    t.integer  "quantity",                                                                       null: false
    t.decimal  "cost_price",                              precision: 12, scale: 2, default: 0.0, null: false
    t.decimal  "amount",                                  precision: 14, scale: 4
    t.decimal  "inventory_cost_price",                    precision: 12, scale: 2, default: 0.0, null: false
    t.string   "remark",                      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_pickings", force: :cascade do |t|
    t.integer  "store_id",                                                                null: false
    t.integer  "store_chain_id",                                                          null: false
    t.integer  "store_staff_id",                                                          null: false
    t.string   "numero",                 limit: 45
    t.integer  "total_quantity"
    t.decimal  "total_amount",                       precision: 14, scale: 4
    t.decimal  "total_inventory_amount",             precision: 14, scale: 4
    t.string   "remark",                 limit: 255
    t.string   "search_keys",            limit: 255
    t.integer  "status",                                                      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_receipts", force: :cascade do |t|
    t.integer  "store_id",                                                             null: false
    t.integer  "store_chain_id",                                                       null: false
    t.integer  "store_staff_id",                                                       null: false
    t.string   "numero",            limit: 45
    t.string   "remark",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "quantity"
    t.decimal  "amount",                        precision: 14, scale: 4, default: 0.0
    t.string   "search_keys"
    t.string   "source_order_type"
    t.integer  "source_order_id"
  end

  create_table "store_material_returning_items", force: :cascade do |t|
    t.integer  "store_id",                                                                       null: false
    t.integer  "store_chain_id",                                                                 null: false
    t.integer  "store_staff_id",                                                                 null: false
    t.integer  "store_supplier_id",                                                              null: false
    t.integer  "store_material_id",                                                              null: false
    t.integer  "store_material_inventory_id",                                                    null: false
    t.integer  "store_depot_id",                                                                 null: false
    t.integer  "store_material_returning_id",                                                    null: false
    t.integer  "quantity",                                                                       null: false
    t.decimal  "price",                                   precision: 12, scale: 2, default: 0.0, null: false
    t.integer  "prior_quantity",                                                                 null: false
    t.string   "remark",                      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_returnings", force: :cascade do |t|
    t.integer  "store_id",                                                             null: false
    t.integer  "store_chain_id",                                                       null: false
    t.integer  "store_staff_id",                                                       null: false
    t.integer  "store_supplier_id",                                                    null: false
    t.string   "numero",            limit: 45,                                         null: false
    t.integer  "total_quantity"
    t.decimal  "total_amount",                  precision: 14, scale: 4, default: 0.0
    t.string   "remark",            limit: 255
    t.string   "search_keys",       limit: 255,                          default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_saleinfo_categories", force: :cascade do |t|
    t.integer  "store_id",                              null: false
    t.integer  "store_chain_id",                        null: false
    t.integer  "store_staff_id",                        null: false
    t.integer  "store_material_category_id"
    t.string   "name",                       limit: 45, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_saleinfo_services", force: :cascade do |t|
    t.integer  "store_id",                                                    null: false
    t.integer  "store_chain_id",                                              null: false
    t.integer  "store_staff_id",                                              null: false
    t.integer  "store_material_id"
    t.integer  "store_material_saleinfo_id"
    t.integer  "store_commission_template_id"
    t.string   "name",                            limit: 45,                  null: false
    t.integer  "mechanic_level",                              default: 1,     null: false
    t.integer  "work_time"
    t.string   "work_time_unit",                  limit: 45
    t.integer  "work_time_in_seconds"
    t.boolean  "tracking_needed",                             default: false
    t.integer  "tracking_delay"
    t.string   "tracking_delay_unit",             limit: 10
    t.integer  "tracking_delay_in_seconds"
    t.integer  "tracking_contact_way"
    t.string   "tracking_content",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mechanic_commission_template_id"
    t.integer  "quantity"
    t.boolean  "deleted",                                     default: false
  end

  create_table "store_material_saleinfos", force: :cascade do |t|
    t.integer  "store_id",                                                                null: false
    t.integer  "store_chain_id",                                                          null: false
    t.integer  "store_staff_id",                                                          null: false
    t.integer  "store_material_id",                                                       null: false
    t.boolean  "bargainable",                                             default: false
    t.decimal  "bargain_price",                  precision: 12, scale: 2, default: 0.0,   null: false
    t.decimal  "retail_price",                   precision: 12, scale: 2, default: 0.0,   null: false
    t.decimal  "trade_price",                    precision: 12, scale: 2, default: 0.0
    t.integer  "reward_points",                                           default: 0
    t.boolean  "divide_to_retail",                                        default: false
    t.integer  "divide_unit_type_id"
    t.decimal  "divide_total_volume",            precision: 10, scale: 2
    t.boolean  "service_needed",                                          default: false
    t.boolean  "service_fee_needed",                                      default: false
    t.decimal  "service_fee",                    precision: 12, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "saleman_commission_template_id"
    t.integer  "sale_category_id"
    t.decimal  "vip_price",                      precision: 12, scale: 2
    t.boolean  "vip_price_enabled",                                       default: false
    t.decimal  "divide_volume_per_bill",         precision: 12, scale: 2, default: 0.0
  end

  create_table "store_material_shrinkage_items", force: :cascade do |t|
    t.integer  "store_id",                                                         null: false
    t.integer  "store_chain_id",                                                   null: false
    t.integer  "store_staff_id",                                                   null: false
    t.integer  "store_material_shrinkage_id",                                      null: false
    t.integer  "store_material_id",                                                null: false
    t.integer  "store_depot_id",                                                   null: false
    t.integer  "store_material_inventory_id",                                      null: false
    t.integer  "quantity"
    t.integer  "prior_quantity"
    t.decimal  "cost_price",                              precision: 12, scale: 2
    t.decimal  "inventory_cost_price",                    precision: 12, scale: 2
    t.decimal  "amount",                                  precision: 14, scale: 4
    t.string   "remark",                      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_shrinkages", force: :cascade do |t|
    t.integer  "store_id",                                                          null: false
    t.integer  "store_chain_id",                                                    null: false
    t.integer  "store_staff_id",                                                    null: false
    t.string   "numero",         limit: 45
    t.integer  "total_quantity",                                      default: 0
    t.decimal  "total_amount",               precision: 14, scale: 4, default: 0.0
    t.string   "remark",         limit: 255
    t.string   "search_keys",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_snapshots", force: :cascade do |t|
    t.integer  "store_id",                                                                            null: false
    t.integer  "store_chain_id",                                                                      null: false
    t.integer  "store_staff_id",                                                                      null: false
    t.integer  "store_material_root_category_id",                                                     null: false
    t.integer  "store_material_category_id",                                                          null: false
    t.integer  "store_material_unit_id",                                                              null: false
    t.integer  "store_material_manufacturer_id",                                                      null: false
    t.integer  "store_material_brand_id",                                                             null: false
    t.string   "name",                            limit: 45,                                          null: false
    t.string   "barcode",                         limit: 45
    t.string   "mnemonic",                        limit: 45
    t.string   "speci",                           limit: 45
    t.decimal  "cost_price",                                 precision: 12, scale: 2
    t.decimal  "min_price",                                  precision: 12, scale: 2
    t.boolean  "inventory_alarmify",                                                  default: false
    t.integer  "min_inventory"
    t.integer  "max_inventory"
    t.boolean  "expiry_alarmify",                                                     default: false
    t.integer  "shelf_life"
    t.boolean  "permitted_to_internal",                                               default: true,  null: false
    t.boolean  "permitted_to_saleable",                                               default: false, null: false
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_material_id"
  end

  create_table "store_material_tracking_sections", force: :cascade do |t|
    t.integer  "store_id",                                               null: false
    t.integer  "store_chain_id",                                         null: false
    t.integer  "store_staff_id",                                         null: false
    t.integer  "store_material_id",                                      null: false
    t.integer  "store_material_tracking_id",                             null: false
    t.integer  "timing",                                 default: 1,     null: false
    t.integer  "delay_interval",                                         null: false
    t.string   "delay_unit",                 limit: 10,                  null: false
    t.integer  "delay_in_seconds",                                       null: false
    t.integer  "contact_way",                            default: 1,     null: false
    t.string   "content",                    limit: 255,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",                                default: false
  end

  create_table "store_material_trackings", force: :cascade do |t|
    t.integer  "store_id",                          null: false
    t.integer  "store_chain_id",                    null: false
    t.integer  "store_staff_id",                    null: false
    t.integer  "store_material_id",                 null: false
    t.boolean  "enabled",           default: false, null: false
    t.integer  "tracking_mode",     default: 0,     null: false
    t.boolean  "reminder_required", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_trans_receipt_items", force: :cascade do |t|
    t.integer  "store_id",                                                            null: false
    t.integer  "store_chain_id",                                                      null: false
    t.integer  "store_staff_id",                                                      null: false
    t.integer  "store_depot_id",                                                      null: false
    t.integer  "store_material_id",                                                   null: false
    t.integer  "store_material_picking_id",                                           null: false
    t.integer  "store_material_picking_item_id",                                      null: false
    t.integer  "store_material_inventory_id",                                         null: false
    t.integer  "store_material_receipt_id",                                           null: false
    t.integer  "quantity",                                                            null: false
    t.integer  "prior_quantity"
    t.integer  "ordered_quantity"
    t.decimal  "prior_cost_price",                           precision: 12, scale: 2
    t.decimal  "ordered_cost_price",                         precision: 12, scale: 2
    t.decimal  "inventory_cost_price",                       precision: 12, scale: 2
    t.decimal  "latest_cost_price",                          precision: 12, scale: 2
    t.string   "remark",                         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_units", force: :cascade do |t|
    t.integer  "store_id",                  null: false
    t.integer  "store_chain_id",            null: false
    t.integer  "store_staff_id",            null: false
    t.string   "name",           limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_materials", force: :cascade do |t|
    t.integer  "store_id",                                                                             null: false
    t.integer  "store_chain_id",                                                                       null: false
    t.integer  "store_staff_id",                                                                       null: false
    t.integer  "store_material_root_category_id",                                                      null: false
    t.integer  "store_material_category_id",                                                           null: false
    t.integer  "store_material_unit_id",                                                               null: false
    t.integer  "store_material_manufacturer_id",                                                       null: false
    t.integer  "store_material_brand_id",                                                              null: false
    t.string   "name",                            limit: 100,                                          null: false
    t.string   "barcode",                         limit: 45
    t.string   "mnemonic",                        limit: 45
    t.string   "speci",                           limit: 45
    t.decimal  "cost_price",                                  precision: 12, scale: 2
    t.decimal  "min_price",                                   precision: 12, scale: 2
    t.boolean  "inventory_alarmify",                                                   default: false
    t.integer  "min_inventory"
    t.integer  "max_inventory"
    t.boolean  "expiry_alarmify",                                                      default: false
    t.integer  "shelf_life"
    t.boolean  "permitted_to_internal",                                                default: true,  null: false
    t.boolean  "permitted_to_saleable",                                                default: false, null: false
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "introduction"
  end

  create_table "store_messages", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.string   "type"
    t.integer  "channel_type_id"
    t.string   "sender_type"
    t.integer  "sender_id"
    t.text     "content",                                 null: false
    t.integer  "store_envelopes_counter", default: 0
    t.integer  "content_length"
    t.boolean  "deleted",                 default: false
    t.boolean  "automatic",               default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_order_items", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",                                                          default: 0
    t.decimal  "price",                                    precision: 12, scale: 2, default: 0.0
    t.decimal  "amount",                                   precision: 14, scale: 4, default: 0.0
    t.string   "remark",                       limit: 255
    t.integer  "orderable_id",                                                                      null: false
    t.string   "orderable_type",               limit: 60,                                           null: false
    t.integer  "store_id",                                                                          null: false
    t.integer  "store_chain_id",                                                                    null: false
    t.integer  "store_staff_id",                                                                    null: false
    t.integer  "store_order_id"
    t.integer  "store_customer_id"
    t.decimal  "discount"
    t.string   "discount_reason"
    t.decimal  "vip_price",                                precision: 12, scale: 2, default: 0.0
    t.decimal  "cost_price",                               precision: 12, scale: 2, default: 0.0
    t.decimal  "retail_price",                             precision: 12, scale: 2, default: 0.0
    t.decimal  "standard_volume_per_bill"
    t.decimal  "actual_volume_per_bill"
    t.boolean  "divide_to_retail",                                                  default: false
    t.boolean  "divide_cost_checked",                                               default: false
    t.boolean  "from_customer_asset",                                               default: false
    t.integer  "store_customer_asset_item_id"
    t.string   "package_type"
    t.integer  "package_id"
    t.string   "assetable_type"
    t.integer  "assetable_id"
    t.boolean  "deleted",                                                           default: false
    t.string   "package_item_type"
    t.integer  "package_item_id"
  end

  add_index "store_order_items", ["orderable_id"], name: "orderable", using: :btree

  create_table "store_order_repayments", force: :cascade do |t|
    t.decimal  "filled"
    t.decimal  "remaining"
    t.integer  "store_order_id"
    t.integer  "store_repayment_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "store_orders", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                                                                                 null: false
    t.integer  "store_chain_id",                                                                           null: false
    t.integer  "store_staff_id",                                                                           null: false
    t.decimal  "amount",                                          precision: 14, scale: 4, default: 0.0
    t.string   "remark",                              limit: 255
    t.integer  "store_customer_id"
    t.integer  "store_vehicle_id"
    t.integer  "state"
    t.string   "numero"
    t.integer  "store_vehicle_registration_plate_id"
    t.boolean  "hanging",                                                                  default: false
    t.integer  "pay_status",                                                               default: 0
    t.integer  "task_status",                                                              default: 0
    t.decimal  "filled",                                          precision: 14, scale: 4, default: 0.0
    t.json     "situation"
    t.integer  "cashier_id",                                                                                            comment: "收银员"
    t.boolean  "service_included",                                                         default: false
    t.boolean  "deleted",                                                                  default: false
    t.integer  "deleted_authorizer_id",                                                                                 comment: "授权人"
    t.integer  "deleted_operator_id",                                                                                   comment: "操作员"
    t.string   "deleted_reason"
    t.datetime "deleted_at"
    t.datetime "paid_at"
  end

  create_table "store_package_items", force: :cascade do |t|
    t.string   "name"
    t.integer  "quantity",                                          default: 1
    t.decimal  "price",                    precision: 12, scale: 2, default: 0.0
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.string   "package_itemable_type"
    t.integer  "package_itemable_id"
    t.integer  "store_package_setting_id"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.decimal  "denomination",             precision: 12, scale: 2
    t.boolean  "deleted",                                           default: false
    t.decimal  "amount",                   precision: 14, scale: 2
  end

  create_table "store_package_settings", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                                                             null: false
    t.integer  "store_chain_id",                                                       null: false
    t.integer  "store_staff_id",                                                       null: false
    t.integer  "store_package_id"
    t.decimal  "retail_price",                 precision: 12, scale: 2, default: 0.0
    t.integer  "period",                                                default: 0
    t.integer  "period_unit",                                           default: 0
    t.boolean  "period_enable",                                         default: true
    t.boolean  "expired_notice_required",                               default: true
    t.integer  "before_expired",                                        default: 0
    t.integer  "store_commission_template_id"
    t.integer  "apply_range",                                           default: 0
    t.integer  "point",                                                 default: 0
    t.integer  "payment_mode",                                          default: 0
  end

  create_table "store_package_trackings", force: :cascade do |t|
    t.integer  "mode"
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.integer  "store_package_id"
    t.boolean  "notice_required",  default: false
    t.string   "content"
    t.integer  "delay_interval",   default: 0
    t.integer  "delay_unit"
    t.integer  "trigger_timing"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "store_packages", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                                                          null: false
    t.integer  "store_chain_id",                                                    null: false
    t.integer  "store_staff_id",                                                    null: false
    t.string   "name",           limit: 45
    t.string   "code",           limit: 45
    t.string   "abstract",       limit: 255
    t.text     "remark"
    t.decimal  "price",                      precision: 12, scale: 2
    t.decimal  "retail_price",               precision: 10, scale: 2, default: 0.0
  end

  create_table "store_payments", force: :cascade do |t|
    t.integer  "staffer_id"
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "renewal_type_id"
    t.datetime "paid_at"
    t.decimal  "amount",           precision: 14, scale: 4, default: 0.0
    t.integer  "payment_type_id"
    t.integer  "invoice_type_id"
    t.boolean  "receipt_required"
    t.string   "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_physical_inventories", force: :cascade do |t|
    t.integer  "store_id",                              null: false
    t.integer  "store_chain_id",                        null: false
    t.integer  "store_staff_id",                        null: false
    t.integer  "store_depot_id",                        null: false
    t.integer  "status",                    default: 0
    t.string   "created_month",  limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_physical_inventory_items", force: :cascade do |t|
    t.integer  "store_id",                                                                       null: false
    t.integer  "store_chain_id",                                                                 null: false
    t.integer  "store_staff_id",                                                                 null: false
    t.integer  "store_material_id",                                                              null: false
    t.integer  "store_depot_id",                                                                 null: false
    t.integer  "store_inventory_id",                                                             null: false
    t.integer  "store_physical_inventory_id",                                                    null: false
    t.integer  "inventory",                                                                      null: false
    t.integer  "physical",                                                                       null: false
    t.integer  "diff",                                                                           null: false
    t.decimal  "inventory_cost_price",                    precision: 12, scale: 2, default: 0.0
    t.decimal  "cost_price",                              precision: 12, scale: 2, default: 0.0
    t.string   "remark",                      limit: 255
    t.integer  "status",                                                           default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_positions", force: :cascade do |t|
    t.integer "store_id"
    t.integer "store_chain_id"
    t.integer "store_staff_id"
    t.integer "store_department_id"
    t.string  "name"
  end

  create_table "store_protocols", force: :cascade do |t|
    t.text     "reason"
    t.date     "effected_on"
    t.integer  "verifier_id"
    t.text     "remark"
    t.integer  "applicant_id"
    t.date     "expired_on"
    t.string   "type"
    t.integer  "store_staff_id"
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.decimal  "previous_salary", precision: 12, scale: 2
    t.decimal  "new_salary",      precision: 12, scale: 2
  end

  create_table "store_repayments", force: :cascade do |t|
    t.decimal  "amount"
    t.integer  "store_customer_id"
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "store_salaries", force: :cascade do |t|
    t.integer  "store_staff_id"
    t.decimal  "amount_deduction",     precision: 14, scale: 4
    t.json     "deduction",                                     default: {}
    t.decimal  "amount_overtime",      precision: 14, scale: 4
    t.decimal  "amount_reward",        precision: 14, scale: 4
    t.decimal  "amount_bonus",         precision: 14, scale: 4
    t.json     "bonus",                                         default: {}
    t.decimal  "amount_insurence",     precision: 14, scale: 4
    t.json     "insurence",                                     default: {}
    t.decimal  "amount_cutfee",        precision: 14, scale: 4
    t.decimal  "amount_should_cutfee", precision: 14, scale: 4
    t.json     "cutfee",                                        default: {}
    t.decimal  "salary_should_pay",    precision: 14, scale: 4
    t.decimal  "salary_actual_pay",    precision: 14, scale: 4
    t.boolean  "status",                                        default: false
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.decimal  "basic_salary",         precision: 12, scale: 2, default: 0.0
    t.string   "created_month"
  end

  create_table "store_service_categories", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                  null: false
    t.integer  "store_chain_id",            null: false
    t.string   "name",           limit: 45, null: false
    t.integer  "store_staff_id"
  end

  create_table "store_service_reminds", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                     null: false
    t.integer  "store_chain_id",               null: false
    t.integer  "store_staff_id",               null: false
    t.string   "content",          limit: 255
    t.integer  "trigger_timing"
    t.integer  "mode"
    t.integer  "delay_interval"
    t.boolean  "notice_required"
    t.integer  "store_service_id"
    t.boolean  "enable"
  end

  create_table "store_service_settings", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                     null: false
    t.integer  "store_chain_id",               null: false
    t.integer  "store_staff_id",               null: false
    t.integer  "setting_type",     default: 0
    t.integer  "store_service_id"
  end

  create_table "store_service_snapshots", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_staff_id",                                                            null: false
    t.integer  "store_chain_id",                                                            null: false
    t.integer  "store_id",                                                                  null: false
    t.string   "name",                  limit: 45
    t.string   "code",                  limit: 45
    t.integer  "standard_time"
    t.integer  "store_service_unit_id"
    t.decimal  "retail_price",                     precision: 12, scale: 2, default: 0.0
    t.decimal  "bargain_price",                    precision: 12, scale: 2, default: 0.0
    t.integer  "point"
    t.text     "introduction"
    t.text     "remark"
    t.integer  "buffering_time"
    t.integer  "factor_time"
    t.integer  "engineer_count"
    t.integer  "engineer_level"
    t.integer  "position_mode"
    t.boolean  "favorable",                                                 default: false
    t.integer  "setting_type",                                              default: 0
    t.integer  "store_service_id"
    t.integer  "store_vehicle_id"
    t.integer  "store_order_id"
    t.integer  "store_order_item_id"
    t.integer  "templateable_id"
    t.string   "templateable_type"
    t.integer  "category_id"
    t.boolean  "deleted",                                                   default: false
  end

  create_table "store_service_store_materials", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",          null: false
    t.integer  "store_chain_id",    null: false
    t.integer  "store_staff_id"
    t.integer  "store_service_id",  null: false
    t.integer  "store_material_id", null: false
  end

  create_table "store_service_trackings", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                                     null: false
    t.integer  "store_chain_id",                               null: false
    t.integer  "store_staff_id",                               null: false
    t.integer  "store_service_id"
    t.integer  "mode",                         default: 1
    t.boolean  "notice_required",              default: false
    t.string   "content",          limit: 255
    t.integer  "delay_interval",               default: 0
    t.integer  "delay_unit"
    t.integer  "trigger_timing"
  end

  create_table "store_service_workflow_snapshots", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                                                    null: false
    t.integer  "store_chain_id",                                              null: false
    t.integer  "store_staff_id",                                              null: false
    t.integer  "engineer_level"
    t.integer  "engineer_count"
    t.integer  "position_mode"
    t.integer  "standard_time"
    t.integer  "buffering_time"
    t.integer  "factor_time"
    t.integer  "store_service_id",                                            null: false
    t.boolean  "engineer_count_enable"
    t.boolean  "engineer_level_enable"
    t.boolean  "standard_time_enable"
    t.boolean  "buffering_time_enable"
    t.string   "store_workstation_ids",           limit: 255
    t.boolean  "nominated_workstation"
    t.string   "name",                            limit: 45
    t.integer  "store_service_workflow_id"
    t.integer  "store_workstation_id"
    t.string   "store_engineer_ids",              limit: 45
    t.integer  "store_service_setting_id"
    t.boolean  "finished",                                    default: false
    t.integer  "used_time",                                   default: 0
    t.json     "mechanics"
    t.integer  "store_vehicle_id"
    t.integer  "store_order_id"
    t.datetime "started_time"
    t.integer  "elapsed"
    t.json     "overtimes",                                   default: []
    t.integer  "status",                                      default: 0
    t.integer  "store_order_item_id"
    t.integer  "mechanic_commission_template_id"
    t.string   "inspector"
    t.boolean  "deleted",                                     default: false
  end

  create_table "store_service_workflows", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                                    null: false
    t.integer  "store_chain_id",                              null: false
    t.integer  "store_staff_id",                              null: false
    t.integer  "engineer_level"
    t.integer  "engineer_count"
    t.integer  "position_mode"
    t.integer  "standard_time"
    t.integer  "buffering_time"
    t.integer  "factor_time"
    t.boolean  "engineer_count_enable"
    t.boolean  "engineer_level_enable"
    t.boolean  "standard_time_enable"
    t.boolean  "buffering_time_enable"
    t.string   "store_workstation_ids",           limit: 255
    t.boolean  "nominated_workstation"
    t.string   "name",                            limit: 45
    t.integer  "store_service_setting_id"
    t.integer  "store_service_id"
    t.integer  "mechanic_commission_template_id"
  end

  create_table "store_services", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_staff_id",                                                                     null: false
    t.integer  "store_chain_id",                                                                     null: false
    t.integer  "store_id",                                                                           null: false
    t.string   "name",                           limit: 45
    t.string   "code",                           limit: 45
    t.integer  "standard_time"
    t.integer  "store_service_unit_id"
    t.decimal  "retail_price",                              precision: 12, scale: 2, default: 0.0
    t.decimal  "bargain_price",                             precision: 12, scale: 2, default: 0.0
    t.integer  "point"
    t.text     "introduction"
    t.text     "remark"
    t.integer  "buffering_time"
    t.integer  "factor_time"
    t.integer  "engineer_count"
    t.integer  "engineer_level"
    t.integer  "position_mode"
    t.boolean  "favorable",                                                          default: false
    t.integer  "setting_type",                                                       default: 0
    t.integer  "category_id"
    t.boolean  "bargain_price_enabled",                                              default: false
    t.integer  "saleman_commission_template_id"
    t.boolean  "vip_price_enabled",                                                  default: false
  end

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

  create_table "store_staff", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.string   "login_name",              limit: 45,                                                   null: false
    t.string   "gender",                  limit: 6,                           default: "male",         null: false
    t.string   "first_name",              limit: 45
    t.string   "last_name",               limit: 45
    t.string   "name_display_type",       limit: 13,                          default: "lastname_pre", null: false
    t.text     "encrypted_password",                                                                   null: false
    t.text     "salt",                                                                                 null: false
    t.integer  "work_status",                                                 default: 0,              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "job_type_id"
    t.integer  "store_department_id"
    t.datetime "employeed_at"
    t.datetime "terminated_at"
    t.integer  "level_type_id"
    t.string   "reason_for_leave"
    t.string   "numero"
    t.integer  "store_position_id"
    t.integer  "store_employee_id"
    t.string   "full_name"
    t.string   "phone_number"
    t.boolean  "mis_login_enabled",                                           default: false
    t.boolean  "app_login_enabled",                                           default: false
    t.boolean  "erp_login_enabled",                                           default: false
    t.integer  "roles",                                                                                             array: true
    t.json     "bonus",                                                       default: {}
    t.decimal  "trial_salary",                       precision: 10, scale: 2
    t.decimal  "regular_salary",                     precision: 10, scale: 2
    t.decimal  "previous_salary",                    precision: 10, scale: 2
    t.integer  "trial_period"
    t.json     "skills",                                                      default: {}
    t.json     "other",                                                       default: {}
    t.boolean  "deduct_enabled",                                              default: false
    t.integer  "deadline_days"
    t.boolean  "contract_notice_enabled",                                     default: false
    t.boolean  "regular",                                                     default: true
    t.boolean  "demission",                                                   default: false
  end

  add_index "store_staff", ["login_name", "work_status"], name: "login_name_work_status_index", using: :btree

  create_table "store_staff_tasks", force: :cascade do |t|
    t.integer  "store_order_item_id"
    t.integer  "store_staff_id"
    t.integer  "workflow_id"
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.string   "taskable_type"
    t.integer  "taskable_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "mechanic_id"
    t.boolean  "deleted",             default: false
  end

  create_table "store_subscribe_order_items", force: :cascade do |t|
    t.integer  "store_subscribe_order_id"
    t.integer  "quantity"
    t.integer  "itemable_id"
    t.string   "itemable_type"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "store_chain_id"
    t.integer  "store_id"
    t.integer  "store_staff_id"
    t.decimal  "price"
  end

  create_table "store_subscribe_orders", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.string   "remark",            limit: 255
    t.integer  "store_customer_id"
    t.integer  "vehicle_id"
    t.datetime "subscribe_date"
    t.integer  "state"
    t.integer  "order_type"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "store_supplier_assessments", force: :cascade do |t|
    t.integer  "store_id",                            null: false
    t.integer  "store_chain_id",                      null: false
    t.integer  "store_staff_id",                      null: false
    t.integer  "store_supplier_id"
    t.integer  "store_material_order_id"
    t.string   "remark",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "remark"
    t.integer  "status",                                     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_switches", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "store_staff_id"
    t.integer  "switchable_id"
    t.string   "switchable_type"
    t.boolean  "enabled",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_trackings", force: :cascade do |t|
    t.string   "title"
    t.integer  "category_id"
    t.integer  "contact_way_id"
    t.text     "content"
    t.text     "feedback"
    t.integer  "creator_id"
    t.integer  "executant_id"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "store_order_id"
    t.boolean  "automatic",           default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_order_item_id"
  end

  create_table "store_vehicle_engines", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                         null: false
    t.integer  "store_chain_id",                   null: false
    t.integer  "store_staff_id",                   null: false
    t.string   "identification_number", limit: 45
    t.integer  "store_vehicle_id"
  end

  create_table "store_vehicle_frames", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                    null: false
    t.integer  "store_chain_id",              null: false
    t.integer  "store_staff_id",              null: false
    t.string   "vin",              limit: 45
    t.integer  "store_vehicle_id"
  end

  create_table "store_vehicle_registration_plates", force: :cascade do |t|
    t.integer  "store_id",                  null: false
    t.integer  "store_chain_id",            null: false
    t.integer  "store_staff_id",            null: false
    t.string   "license_number", limit: 45, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_vehicles", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",          null: false
    t.integer  "store_chain_id",    null: false
    t.integer  "store_staff_id",    null: false
    t.integer  "store_customer_id"
    t.integer  "vehicle_brand_id"
    t.integer  "vehicle_model_id"
    t.integer  "vehicle_series_id"
    t.json     "detail"
    t.string   "numero"
    t.text     "remark"
  end

  create_table "store_workstation_categories", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                  null: false
    t.integer  "store_chain_id",            null: false
    t.integer  "store_staff_id",            null: false
    t.string   "name",           limit: 45
  end

  create_table "store_workstations", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                                             null: false
    t.integer  "store_chain_id",                                       null: false
    t.integer  "store_staff_id",                                       null: false
    t.string   "name",                          limit: 45,             null: false
    t.integer  "store_workstation_category_id"
    t.integer  "workflow_id"
    t.string   "color"
    t.integer  "status",                                   default: 0
    t.integer  "store_group_id"
  end

  create_table "stores", force: :cascade do |t|
    t.integer  "store_chain_id",                            null: false
    t.integer  "admin_id"
    t.string   "name",            limit: 60,                null: false
    t.integer  "business_status",            default: 0
    t.integer  "payment_status",             default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expired_at"
    t.decimal  "balance"
    t.boolean  "available",                  default: true
    t.integer  "creator_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "store_staff_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "store_id"
    t.integer  "store_chain_id"
  end

  create_table "vehicle_brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "letter"
  end

  create_table "vehicle_engines", force: :cascade do |t|
    t.integer  "store_vehicle_id"
    t.integer  "store_vehicle_engine_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "vehicle_manufacturers", force: :cascade do |t|
    t.string   "name"
    t.integer  "vehicle_brand_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "vehicle_models", force: :cascade do |t|
    t.string   "name"
    t.integer  "vehicle_series_id"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "manufacturing_year"
    t.decimal  "min_price",          precision: 12, scale: 2, default: 0.0
    t.decimal  "max_price",          precision: 12, scale: 2, default: 0.0
  end

  create_table "vehicle_plates", force: :cascade do |t|
    t.integer  "store_vehicle_id"
    t.integer  "store_vehicle_registration_plate_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "vehicle_series", force: :cascade do |t|
    t.string   "name"
    t.integer  "vehicle_brand_id",                                                            comment: "所属品牌"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.decimal  "min",                     precision: 11, scale: 2, default: 0.0
    t.decimal  "max",                     precision: 11, scale: 2, default: 0.0
    t.integer  "vehicle_manufacturer_id"
  end

end
