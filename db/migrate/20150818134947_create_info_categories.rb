
class CreateInfoCategories < ActiveRecord::Migration
  def change
    create_table "info_categories", force: :cascade do |t|
      t.string   "name",       limit: 45, null: false
      t.integer  "parent_id"
      t.datetime "created_at"
      t.datetime "updated_at"
     end
  end
end
