class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string  :type
      t.string  :creator_type
      t.integer :creator_id
      t.text    :content, null: false
      t.integer :envelopes_count, default: 0
      t.integer :status, default: 0

      t.timestamps null: false
    end

    add_index :notifications, [:type, :status]
    add_index :notifications, [:creator_type, :creator_id]
  end
end
