
class CreateStoreTrackings < ActiveRecord::Migration
  def change
    create_table "store_trackings", force: :cascade do |t|
      t.string "title"
      t.integer "category_id"
      t.integer "contact_way_id"
      t.text "content"
      t.text "feedback"
      t.integer "creator_id"
      t.integer "executant_id"
      t.integer "trackable_id"
      t.string "trackable_type"
      t.integer "store_order_id"
      t.boolean "automatic", default: true
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
