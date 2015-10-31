
class CreateStoreMaterialSaleinfos < ActiveRecord::Migration
  def change
    create_table "store_material_saleinfos", force: :cascade do |t|
      t.integer  "store_id",                                                    null: false
      t.integer  "store_chain_id",                                              null: false
      t.integer  "store_staff_id",                                              null: false
      t.integer  "store_material_id",                                           null: false
      t.boolean  "bargainable",                                 default: false
      t.decimal  "bargain_price",      precision: 10, scale: 2, default: 0.0,   null: false
      t.decimal  "retail_price",       precision: 10, scale: 2, default: 0.0,   null: false
      t.decimal  "trade_price",        precision: 10, scale: 2, default: 0.0,   null: false
      t.integer  "reward_points",                               default: 0
      t.boolean  "divide_to_retail",                            default: false
      t.integer  "unit"
      t.decimal  "volume",             precision: 10, scale: 2
      t.boolean  "service_needed",                              default: false
      t.boolean  "service_fee_needed",                          default: false
      t.decimal  "service_fee",        precision: 10, scale: 2
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
