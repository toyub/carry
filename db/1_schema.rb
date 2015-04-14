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

ActiveRecord::Schema.define(version: 0) do

  create_table "store_attachments", force: :cascade do |t|
    t.string   "type",         limit: 45, null: false
    t.integer  "host_id",      limit: 4,  null: false
    t.string   "file_name",    limit: 45, null: false
    t.integer  "file_size",    limit: 4,  null: false
    t.string   "content_type", limit: 45, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_attachments", ["type", "host_id"], name: "type_of_attachments", using: :btree

  create_table "store_chains", force: :cascade do |t|
    t.integer  "admin_store_id", limit: 4
    t.integer  "admin_id",       limit: 4
    t.boolean  "chain_enabled",  limit: 1, default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_depots", force: :cascade do |t|
    t.integer  "store_id",       limit: 4,  null: false
    t.integer  "store_chain_id", limit: 4,  null: false
    t.integer  "store_staff_id", limit: 4,  null: false
    t.string   "name",           limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_brands", force: :cascade do |t|
    t.integer  "store_id",       limit: 4
    t.integer  "store_chain_id", limit: 4
    t.integer  "store_staff_id", limit: 4
    t.string   "name",           limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_categories", force: :cascade do |t|
    t.integer  "store_id",       limit: 4,              null: false
    t.integer  "store_chain_id", limit: 4,              null: false
    t.integer  "store_staff_id", limit: 4,              null: false
    t.integer  "parent_id",      limit: 4,  default: 0, null: false
    t.string   "name",           limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_commissions", force: :cascade do |t|
    t.integer  "store_id",       limit: 4,                                         null: false
    t.integer  "store_chain_id", limit: 4,                                         null: false
    t.integer  "store_staff_id", limit: 4,                                         null: false
    t.string   "type",           limit: 45
    t.decimal  "percentage",                precision: 6,  scale: 3, default: 0.0
    t.decimal  "flatfee",                   precision: 10, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "store_material_commissions", ["type"], name: "type", using: :btree

  create_table "store_material_inventories", force: :cascade do |t|
    t.integer  "store_id",          limit: 4,             null: false
    t.integer  "store_chain_id",    limit: 4,             null: false
    t.integer  "store_staff_id",    limit: 4,             null: false
    t.integer  "store_material_id", limit: 4,             null: false
    t.integer  "store_depot_id",    limit: 4,             null: false
    t.integer  "quantity",          limit: 4, default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_inventory_records", force: :cascade do |t|
    t.integer  "store_id",                     limit: 4,                          null: false
    t.integer  "store_chain_id",               limit: 4,                          null: false
    t.integer  "store_staff_id",               limit: 4,                          null: false
    t.integer  "store_depot_id",               limit: 4,                          null: false
    t.integer  "store_material_id",            limit: 4,                          null: false
    t.integer  "store_material_order_id",      limit: 4,                          null: false
    t.integer  "store_material_order_item_id", limit: 4,                          null: false
    t.integer  "store_material_inventory_id",  limit: 4,                          null: false
    t.integer  "quantity",                     limit: 4,                          null: false
    t.integer  "prior_quantity",               limit: 4
    t.integer  "ordered_quantiry",             limit: 4
    t.decimal  "prior_cost_price",                       precision: 10, scale: 2
    t.decimal  "ordered_cost_price",                     precision: 10, scale: 2
    t.decimal  "latest_cost_price",                      precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_manufacturers", force: :cascade do |t|
    t.integer  "store_id",       limit: 4,  null: false
    t.integer  "store_chain_id", limit: 4,  null: false
    t.integer  "store_staff_id", limit: 4,  null: false
    t.string   "name",           limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_order_items", force: :cascade do |t|
    t.integer  "store_id",                limit: 4,                                        null: false
    t.integer  "store_chain_id",          limit: 4,                                        null: false
    t.integer  "store_staff_id",          limit: 4,                                        null: false
    t.integer  "store_material_id",       limit: 4,                                        null: false
    t.integer  "store_supplier_id",       limit: 4,                                        null: false
    t.integer  "store_material_order_id", limit: 4,                                        null: false
    t.decimal  "price",                               precision: 10, scale: 2,             null: false
    t.integer  "quantity",                limit: 4,                                        null: false
    t.integer  "received_quantity",       limit: 4,                            default: 0, null: false
    t.integer  "returned_quantity",       limit: 4,                            default: 0, null: false
    t.integer  "process",                 limit: 4,                            default: 0, null: false
    t.decimal  "amount",                              precision: 12, scale: 4
    t.string   "remark",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_orders", force: :cascade do |t|
    t.integer  "store_id",          limit: 4,                                        null: false
    t.integer  "store_chain_id",    limit: 4,                                        null: false
    t.integer  "store_staff_id",    limit: 4,                                        null: false
    t.integer  "store_supplier_id", limit: 4,                                        null: false
    t.string   "numero",            limit: 45
    t.decimal  "amount",                        precision: 12, scale: 4
    t.integer  "process",           limit: 4,                            default: 0, null: false
    t.string   "remark",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_saleinfos", force: :cascade do |t|
    t.integer  "store_id",          limit: 4,                                        null: false
    t.integer  "store_chain_id",    limit: 4,                                        null: false
    t.integer  "store_staff_id",    limit: 4,                                        null: false
    t.integer  "store_material_id", limit: 4,                                        null: false
    t.decimal  "bargain_price",               precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "retail_price",                precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "trade_price",                 precision: 10, scale: 2, default: 0.0, null: false
    t.integer  "reward_points",     limit: 4,                          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_material_units", force: :cascade do |t|
    t.integer  "store_id",       limit: 4,  null: false
    t.integer  "store_chain_id", limit: 4,  null: false
    t.integer  "store_staff_id", limit: 4,  null: false
    t.string   "name",           limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_materials", force: :cascade do |t|
    t.integer  "store_id",                       limit: 4,                                              null: false
    t.integer  "store_chain_id",                 limit: 4,                                              null: false
    t.integer  "store_staff_id",                 limit: 4,                                              null: false
    t.integer  "store_material_category_id",     limit: 4,                                              null: false
    t.integer  "store_material_unit_id",         limit: 4,                              default: 0,     null: false
    t.integer  "store_material_manufacturer_id", limit: 4
    t.integer  "store_material_brand_id",        limit: 4
    t.string   "name",                           limit: 45,                                             null: false
    t.string   "barcode",                        limit: 45
    t.string   "mnemonic",                       limit: 45
    t.string   "speci",                          limit: 45
    t.decimal  "cost_price",                                   precision: 10, scale: 2, default: 0.0,   null: false
    t.decimal  "min_price",                                    precision: 10, scale: 2, default: 0.0,   null: false
    t.boolean  "inventory_alarmify",             limit: 1,                              default: false
    t.integer  "min_inventory",                  limit: 4
    t.integer  "max_inventory",                  limit: 4
    t.boolean  "expiry_alarmify",                limit: 1,                              default: false
    t.integer  "shelf_life",                     limit: 4
    t.text     "remark",                         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_staff", force: :cascade do |t|
    t.integer  "store_id",           limit: 4
    t.integer  "store_chain_id",     limit: 4
    t.string   "login_name",         limit: 45,                              null: false
    t.string   "gender",             limit: 6,     default: "male",          null: false
    t.string   "first_name",         limit: 45
    t.string   "last_name",          limit: 45
    t.string   "name_display_type",  limit: 13,    default: "firstname_pre", null: false
    t.string   "phone_number",       limit: 33,                              null: false
    t.text     "encrypted_password", limit: 65535,                           null: false
    t.text     "salt",               limit: 65535,                           null: false
    t.string   "work_status",        limit: 2,     default: "在职"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_suppliers", force: :cascade do |t|
    t.integer  "store_id",       limit: 4,  null: false
    t.integer  "store_chain_id", limit: 4,  null: false
    t.integer  "store_staff_id", limit: 4,  null: false
    t.string   "name",           limit: 45, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", force: :cascade do |t|
    t.integer  "store_chain_id", limit: 4,  null: false
    t.integer  "admin_id",       limit: 4
    t.string   "name",           limit: 60, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
