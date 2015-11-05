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

ActiveRecord::Schema.define(version: 20151105021840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ca_stations", force: :cascade do |t|
    t.integer  "store_id",                  null: false
    t.integer  "store_chain_id",            null: false
    t.string   "name",           limit: 45
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "info_categories", force: :cascade do |t|
    t.string   "name",       limit: 45, null: false
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "store_customers", force: :cascade do |t|
    t.integer  "store_id",                  null: false
    t.integer  "store_chain_id",            null: false
    t.integer  "store_staff_id",            null: false
    t.string   "first_name",     limit: 45, null: false
    t.string   "last_name",      limit: 45, null: false
    t.string   "full_name",      limit: 45, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number",   limit: 45
  end

  create_table "store_depots", force: :cascade do |t|
    t.integer  "store_id",                  null: false
    t.integer  "store_chain_id",            null: false
    t.integer  "store_staff_id",            null: false
    t.string   "name",           limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "type",           limit: 45
  end

  add_index "store_files", ["fileable_id", "fileable_type"], name: "fileable", using: :btree

  create_table "store_infos", force: :cascade do |t|
    t.integer  "store_id",                     null: false
    t.integer  "store_chain_id"
    t.integer  "info_category_id",             null: false
    t.string   "value",            limit: 45
    t.string   "remark",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "state"
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
    t.decimal  "price",                                   precision: 10, scale: 2
    t.decimal  "amount",                                  precision: 10, scale: 2
    t.decimal  "prior_cost_price",                        precision: 10, scale: 2
    t.decimal  "latest_cost_price",                       precision: 10, scale: 2
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
    t.decimal  "amount",                     precision: 10, scale: 2, default: 0.0
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
    t.decimal  "cost_price",        precision: 10, scale: 2, default: 0.0
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
    t.decimal  "prior_cost_price",             precision: 10, scale: 2
    t.decimal  "ordered_cost_price",           precision: 10, scale: 2
    t.decimal  "latest_cost_price",            precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_logs", force: :cascade do |t|
    t.integer  "store_id",                     null: false
    t.integer  "store_chain_id",               null: false
    t.integer  "store_staff_id",               null: false
    t.string   "store_material_id", limit: 45, null: false
    t.string   "log_type",          limit: 45
    t.text     "prior_value"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.decimal  "price",                               precision: 10, scale: 2,             null: false
    t.integer  "quantity",                                                                 null: false
    t.integer  "received_quantity",                                            default: 0, null: false
    t.integer  "returned_quantity",                                            default: 0, null: false
    t.integer  "process",                                                      default: 0, null: false
    t.decimal  "amount",                              precision: 12, scale: 4
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
    t.decimal  "amount",                      precision: 10, scale: 2
    t.decimal  "order_balance",               precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_orders", force: :cascade do |t|
    t.integer  "store_id",                                                             null: false
    t.integer  "store_chain_id",                                                       null: false
    t.integer  "store_staff_id",                                                       null: false
    t.integer  "store_supplier_id",                                                    null: false
    t.string   "numero",            limit: 45
    t.decimal  "amount",                        precision: 12, scale: 4, default: 0.0
    t.integer  "quantity",                                               default: 0
    t.decimal  "paid_amount",                   precision: 10, scale: 2, default: 0.0
    t.integer  "process",                                                default: 0,   null: false
    t.string   "remark",            limit: 255
    t.integer  "status",                                                 default: 0
    t.integer  "paid_status",                                            default: 0
    t.integer  "received_status",                                        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.decimal  "amount",                                  precision: 10, scale: 2
    t.decimal  "cost_price",                              precision: 10, scale: 2
    t.decimal  "inventory_cost_price",                    precision: 10, scale: 2
    t.string   "remark",                      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_outings", force: :cascade do |t|
    t.integer  "store_id",                                            null: false
    t.integer  "store_chain_id",                                      null: false
    t.integer  "store_staff_id",                                      null: false
    t.integer  "requester_id"
    t.integer  "outing_type_id"
    t.string   "numero",         limit: 45
    t.integer  "total_quantity"
    t.decimal  "total_amount",               precision: 10, scale: 2
    t.string   "remark",         limit: 45
    t.string   "search_keys",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_picking_items", force: :cascade do |t|
    t.integer  "store_id",                                                         null: false
    t.integer  "store_chain_id",                                                   null: false
    t.integer  "store_staff_id",                                                   null: false
    t.integer  "store_depot_id",                                                   null: false
    t.integer  "dest_depot_id",                                                    null: false
    t.integer  "store_material_id",                                                null: false
    t.integer  "store_material_inventory_id",                                      null: false
    t.integer  "store_material_picking_id",                                        null: false
    t.integer  "quantity",                                                         null: false
    t.decimal  "cost_price",                              precision: 10, scale: 2, null: false
    t.decimal  "amount",                                  precision: 10, scale: 2
    t.decimal  "inventory_cost_price",                    precision: 10, scale: 2
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
    t.decimal  "total_amount",                       precision: 10, scale: 2
    t.decimal  "total_inventory_amount",             precision: 10, scale: 2
    t.string   "remark",                 limit: 255
    t.string   "search_keys",            limit: 255
    t.integer  "status",                                                      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_receipts", force: :cascade do |t|
    t.integer  "store_id",                   null: false
    t.integer  "store_chain_id",             null: false
    t.integer  "store_staff_id",             null: false
    t.string   "numero",         limit: 45
    t.string   "remark",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_returning_items", force: :cascade do |t|
    t.integer  "store_id",                                                         null: false
    t.integer  "store_chain_id",                                                   null: false
    t.integer  "store_staff_id",                                                   null: false
    t.integer  "store_supplier_id",                                                null: false
    t.integer  "store_material_id",                                                null: false
    t.integer  "store_material_inventory_id",                                      null: false
    t.integer  "store_depot_id",                                                   null: false
    t.integer  "store_material_returning_id",                                      null: false
    t.integer  "quantity",                                                         null: false
    t.decimal  "price",                                   precision: 10, scale: 2, null: false
    t.integer  "prior_quantity",                                                   null: false
    t.string   "remark",                      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_returnings", force: :cascade do |t|
    t.integer  "store_id",                                                            null: false
    t.integer  "store_chain_id",                                                      null: false
    t.integer  "store_staff_id",                                                      null: false
    t.integer  "store_supplier_id",                                                   null: false
    t.string   "numero",            limit: 45,                                        null: false
    t.integer  "total_quantity"
    t.decimal  "total_amount",                  precision: 10, scale: 2
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
  end

  create_table "store_material_saleinfos", force: :cascade do |t|
    t.integer  "store_id",                                                                     null: false
    t.integer  "store_chain_id",                                                               null: false
    t.integer  "store_staff_id",                                                               null: false
    t.integer  "store_material_id",                                                            null: false
    t.boolean  "bargainable",                                                  default: false
    t.decimal  "bargain_price",                       precision: 10, scale: 2, default: 0.0,   null: false
    t.decimal  "retail_price",                        precision: 10, scale: 2, default: 0.0,   null: false
    t.decimal  "trade_price",                         precision: 10, scale: 2, default: 0.0,   null: false
    t.integer  "reward_points",                                                default: 0
    t.boolean  "divide_to_retail",                                             default: false
    t.integer  "unit"
    t.decimal  "volume",                              precision: 10, scale: 2
    t.boolean  "service_needed",                                               default: false
    t.boolean  "service_fee_needed",                                           default: false
    t.decimal  "service_fee",                         precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "saleman_commission_template_id"
    t.integer  "store_material_saleinfo_category_id"
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
    t.decimal  "cost_price",                              precision: 10, scale: 2
    t.decimal  "inventory_cost_price",                    precision: 10, scale: 2
    t.decimal  "amount",                                  precision: 10, scale: 2
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
    t.decimal  "total_amount",               precision: 10, scale: 2, default: 0.0
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
    t.decimal  "cost_price",                                 precision: 10, scale: 2
    t.decimal  "min_price",                                  precision: 10, scale: 2
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
    t.integer  "store_id",                                           null: false
    t.integer  "store_chain_id",                                     null: false
    t.integer  "store_staff_id",                                     null: false
    t.integer  "store_material_id",                                  null: false
    t.integer  "store_material_tracking_id",                         null: false
    t.integer  "timing",                                 default: 1, null: false
    t.integer  "delay_interval",                                     null: false
    t.string   "delay_unit",                 limit: 10,              null: false
    t.integer  "delay_in_seconds",                                   null: false
    t.integer  "contact_way",                            default: 1, null: false
    t.string   "content",                    limit: 255,             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.decimal  "prior_cost_price",                           precision: 10, scale: 2
    t.decimal  "ordered_cost_price",                         precision: 10, scale: 2
    t.decimal  "inventory_cost_price",                       precision: 10, scale: 2
    t.decimal  "latest_cost_price",                          precision: 10, scale: 2
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
    t.decimal  "cost_price",                                  precision: 10, scale: 2
    t.decimal  "min_price",                                   precision: 10, scale: 2
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
  end

  create_table "store_order_items", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",                                               default: 0
    t.decimal  "price",                         precision: 10, scale: 4, default: 0.0
    t.decimal  "amount",                        precision: 12, scale: 4, default: 0.0
    t.string   "remark",            limit: 255
    t.integer  "orderable_id",                                                         null: false
    t.string   "orderable_type",    limit: 60,                                         null: false
    t.integer  "store_id",                                                             null: false
    t.integer  "store_chain_id",                                                       null: false
    t.integer  "store_staff_id",                                                       null: false
    t.integer  "store_order_id"
    t.integer  "store_customer_id"
  end

  add_index "store_order_items", ["orderable_id"], name: "orderable", using: :btree

  create_table "store_orders", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                                                             null: false
    t.integer  "store_chain_id",                                                       null: false
    t.integer  "store_staff_id",                                                       null: false
    t.decimal  "amount",                        precision: 12, scale: 4, default: 0.0
    t.string   "remark",            limit: 255
    t.integer  "store_customer_id"
    t.integer  "store_vehicle_id"
    t.integer  "state"
  end

  create_table "store_package_settings", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                                                             null: false
    t.integer  "store_chain_id",                                                       null: false
    t.integer  "store_staff_id",                                                       null: false
    t.integer  "store_package_id"
    t.decimal  "retail_price",                 precision: 10, scale: 2, default: 0.0
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

  create_table "store_packages", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                   null: false
    t.integer  "store_chain_id",             null: false
    t.integer  "store_staff_id",             null: false
    t.string   "name",           limit: 45
    t.string   "code",           limit: 45
    t.string   "abstract",       limit: 255
    t.text     "remark"
  end

  create_table "store_payments", force: :cascade do |t|
    t.integer  "staffer_id"
    t.integer  "store_id"
    t.integer  "store_chain_id"
    t.integer  "renewal_type_id"
    t.datetime "paid_at"
    t.decimal  "amount",           precision: 10, scale: 2
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
    t.integer  "store_id",                                                                     null: false
    t.integer  "store_chain_id",                                                               null: false
    t.integer  "store_staff_id",                                                               null: false
    t.integer  "store_material_id",                                                            null: false
    t.integer  "store_depot_id",                                                               null: false
    t.integer  "store_inventory_id",                                                           null: false
    t.integer  "store_physical_inventory_id",                                                  null: false
    t.integer  "inventory",                                                                    null: false
    t.integer  "physical",                                                                     null: false
    t.integer  "diff",                                                                         null: false
    t.decimal  "inventory_cost_price",                    precision: 10, scale: 2
    t.decimal  "cost_price",                              precision: 10, scale: 2
    t.string   "remark",                      limit: 255
    t.integer  "status",                                                           default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "store_staff_id",                                                                null: false
    t.integer  "store_chain_id",                                                                null: false
    t.integer  "store_id",                                                                      null: false
    t.string   "name",                      limit: 45
    t.string   "code",                      limit: 45
    t.integer  "standard_time"
    t.integer  "store_service_unit_id"
    t.decimal  "retail_price",                         precision: 10, scale: 2, default: 0.0
    t.decimal  "bargain_price",                        precision: 10, scale: 2, default: 0.0
    t.integer  "point"
    t.text     "introduction"
    t.text     "remark"
    t.integer  "store_service_category_id"
    t.integer  "buffering_time"
    t.integer  "factor_time"
    t.integer  "engineer_count"
    t.integer  "engineer_level"
    t.integer  "position_mode"
    t.boolean  "favorable",                                                     default: false
    t.integer  "setting_type",                                                  default: 0
    t.integer  "store_service_id"
  end

  add_index "store_service_snapshots", ["store_service_category_id"], name: "store_service_snapshots_store_service_category_id", using: :btree

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
    t.integer  "store_id",                                    null: false
    t.integer  "store_chain_id",                              null: false
    t.integer  "store_staff_id",                              null: false
    t.integer  "engineer_level"
    t.integer  "engineer_count"
    t.integer  "position_mode"
    t.integer  "standard_time"
    t.integer  "buffering_time"
    t.integer  "factor_time"
    t.integer  "store_service_id",                            null: false
    t.integer  "sales_commission_subject"
    t.integer  "sales_commission_template_id"
    t.integer  "engineer_commission_subject"
    t.integer  "engineer_commission_template_id"
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
    t.integer  "sales_commission_subject"
    t.integer  "sales_commission_template_id"
    t.integer  "engineer_commission_subject"
    t.integer  "engineer_commission_template_id"
    t.boolean  "engineer_count_enable"
    t.boolean  "engineer_level_enable"
    t.boolean  "standard_time_enable"
    t.boolean  "buffering_time_enable"
    t.string   "store_workstation_ids",           limit: 255
    t.boolean  "nominated_workstation"
    t.string   "name",                            limit: 45
    t.integer  "store_service_setting_id"
    t.integer  "store_service_id"
  end

  create_table "store_services", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_staff_id",                                                                null: false
    t.integer  "store_chain_id",                                                                null: false
    t.integer  "store_id",                                                                      null: false
    t.string   "name",                      limit: 45
    t.string   "code",                      limit: 45
    t.integer  "standard_time"
    t.integer  "store_service_unit_id"
    t.decimal  "retail_price",                         precision: 10, scale: 2, default: 0.0
    t.decimal  "bargain_price",                        precision: 10, scale: 2, default: 0.0
    t.integer  "point"
    t.text     "introduction"
    t.text     "remark"
    t.integer  "store_service_category_id"
    t.integer  "buffering_time"
    t.integer  "factor_time"
    t.integer  "engineer_count"
    t.integer  "engineer_level"
    t.integer  "position_mode"
    t.boolean  "favorable",                                                     default: false
    t.integer  "setting_type",                                                  default: 0
  end

  add_index "store_services", ["store_service_category_id"], name: "store_services_store_service_category_id", using: :btree

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
    t.string   "login_name",         limit: 45,                          null: false
    t.string   "gender",             limit: 6,  default: "male",         null: false
    t.string   "first_name",         limit: 45
    t.string   "last_name",          limit: 45
    t.string   "name_display_type",  limit: 13, default: "lastname_pre", null: false
    t.text     "encrypted_password",                                     null: false
    t.text     "salt",                                                   null: false
    t.integer  "work_status",                   default: 0,              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_staff", ["login_name", "work_status"], name: "login_name_work_status_index", using: :btree

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
    t.string   "remark",                          limit: 45
    t.integer  "status",                                     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_vehicle_brands", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                  null: false
    t.integer  "store_chain_id",            null: false
    t.integer  "store_staff_id",            null: false
    t.string   "name",           limit: 45
  end

  create_table "store_vehicle_engines", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                         null: false
    t.integer  "store_chain_id",                   null: false
    t.integer  "store_staff_id",                   null: false
    t.string   "identification_number", limit: 45
    t.integer  "store_vehicle_id"
    t.integer  "store_customer_id"
  end

  create_table "store_vehicle_frames", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                     null: false
    t.integer  "store_chain_id",               null: false
    t.integer  "store_staff_id",               null: false
    t.string   "vin",               limit: 45
    t.integer  "store_vehicle_id"
    t.integer  "store_customer_id"
  end

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

  create_table "store_vehicles", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id",                          null: false
    t.integer  "store_chain_id",                    null: false
    t.integer  "store_staff_id",                    null: false
    t.string   "model",                  limit: 45
    t.string   "series",                 limit: 45
    t.integer  "store_vehicle_brand_id"
    t.integer  "store_customer_id"
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
    t.integer  "store_id",                                 null: false
    t.integer  "store_chain_id",                           null: false
    t.integer  "store_staff_id",                           null: false
    t.string   "name",                          limit: 45, null: false
    t.integer  "store_workstation_category_id"
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
  end

end
