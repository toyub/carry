class CreateStoreMessages < ActiveRecord::Migration
  def change
    create_table :store_messages do |t|
      t.integer   :store_id
      t.integer   :store_chain_id
      t.integer   :store_staff_id
      t.string    :type
      t.integer   :channel_type_id
      t.string    :sender_type
      t.integer   :sender_id
      t.text      :content,                                               null: false
      t.integer   :store_envelopes_counter,         default: 0
      t.integer   :content_length
      t.boolean   :deleted,                         default: false
      t.boolean   :automatic,                       default: true
      
      t.datetime  :created_at
      t.datetime  :updated_at
    end
  end
end
