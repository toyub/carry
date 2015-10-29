
class CreateStoreAttachments < ActiveRecord::Migration
  def change
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
     
  end
end
