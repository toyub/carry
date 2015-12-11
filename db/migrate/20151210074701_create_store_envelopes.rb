class CreateStoreEnvelopes < ActiveRecord::Migration
  def change
    create_table :store_envelopes do |t|
      t.integer   :store_message_id
      t.integer   :store_id
      t.integer   :store_chain_id
      t.integer   :store_staff_id
      t.string    :receiver_type
      t.integer   :receiver_id
      t.boolean   :opened,                  default: false
      t.boolean   :deleted,                 default: false
      
      t.datetime  :created_at
      t.datetime  :update_at
    end
  end
end
