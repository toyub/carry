
class CreateStoreServiceWorkflows < ActiveRecord::Migration
  def change
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
  end
end
