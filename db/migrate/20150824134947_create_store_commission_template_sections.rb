
class CreateStoreCommissionTemplateSections < ActiveRecord::Migration
  def change
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
  end
end
