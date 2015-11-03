
class CreateStorePackageSettings < ActiveRecord::Migration
  def change
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
  end
end
