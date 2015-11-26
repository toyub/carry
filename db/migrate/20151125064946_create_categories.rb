
class CreateCategories < ActiveRecord::Migration
  def change
    create_table "categories", force: :cascade do |t|
      t.string "name"
      t.integer "parent_id"
      t.string "type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
