class CreateEnvelopes < ActiveRecord::Migration
  def change
    create_table :envelopes do |t|
      t.string  :extra_type
      t.string  :message_type
      t.integer :message_id
      t.string  :receiver_type
      t.integer :receiver_id
      t.string  :sender_type
      t.integer :sender_id
      t.integer :status,  default: 0


      t.timestamps null: false
    end

    add_index :envelopes, [:message_type, :message_id]
    add_index :envelopes, [:receiver_type, :receiver_id]
    add_index :envelopes, [:sender_type, :sender_id]
    add_index :envelopes, [:status]
    add_index :envelopes, [:extra_type]
  end
end
